import 'dart:convert';

import 'package:zyra/model/productlist.dart';
import 'package:zyra/model/user.dart';
import 'package:zyra/pages/home/homepage.dart';
import 'package:zyra/pages/login/loginpage.dart';
import 'package:zyra/providers/RepairReqestProvider.dart';
import 'package:zyra/providers/categoryProvider.dart';
import 'package:zyra/providers/locationListProvider.dart';
import 'package:zyra/providers/productProvider.dart';
import 'package:zyra/providers/userProvider.dart';
import 'package:zyra/services/sqllite_helper.dart';
import 'package:zyra/services/test_data.dart';
import 'package:zyra/utils/constants.dart';
import 'package:zyra/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String city,
    required String password,
    required String phoneNumber,
  }) async {
    final navigator = Navigator.of(context);
    if (name.isEmpty ||
        email.isEmpty ||
        city.isEmpty ||
        phoneNumber.isEmpty ||
        password.isEmpty) {
      showSnackBar(context, 'All fields are required.');
      return;
    }
    print("int signin");

    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'city': city,
          'password': password,
        }),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials',
          );
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void logInUser({
    required BuildContext context,
    required String password,
    required String phoneNumber,
  }) async {
    if (phoneNumber.isEmpty || password.isEmpty) {
      showSnackBar(context, 'All fields are required.');
      return;
    }
    print(phoneNumber);
    print(password);

    try {
      final navigator = Navigator.of(context);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      print("logging in");
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}users/login'),
        // body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumber,
          'password': password,
        }),
      );
      print('Response status: ${res.statusCode}');
      print('Response status: ${res}');
      print('Response body: ${res.body}');
      print('Response real body: ${jsonDecode(res.body)['body']}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final responseBody = jsonDecode(res.body);
          final userBody = responseBody['body'];
          userProvider.setUser(jsonEncode(jsonDecode(res.body)['body']));
          await prefs.setString(
            'user',
            jsonEncode(jsonDecode(res.body)['body']),
          );
          String? fcmtoken = await prefs.getString("fcmtoken");
          String userid = userBody['_id'];
          if (fcmtoken != null && fcmtoken.isNotEmpty) {
            updateFcmToken(userid: userid, fcmtoken: fcmtoken);
          }
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
          // showSnackBar(
          //   context,
          //   'Logged in Successfully!',
          // );
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void updateUser(
      {required BuildContext context,
      required String userid,
      String? name,
      String? city,
      String? fcmtoken}) async {
    if (userid.isEmpty) {
      showSnackBar(context, 'userid is required.');
      return;
    }

    try {
      final navigator = Navigator.of(context);
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      print("logging in");

      Map<String, String> requestBody = {
        'userid': userid,
      };

      if (name != null) requestBody['name'] = name;
      if (city != null) requestBody['city'] = city;
      if (fcmtoken != null) requestBody['fcmtoken'] = fcmtoken;
      http.Response res = await http.post(
          Uri.parse('${Constants.uri}users/update'),
          // body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(requestBody));
      print('Response status: ${res.statusCode}');
      print('Response status: ${res}');
      print('Response body: ${res.body}');
      print('Response real body: ${jsonDecode(res.body)['body']}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          userProvider.setUser(jsonEncode(jsonDecode(res.body)['body']));
          await prefs.setString(
            'user',
            jsonEncode(jsonDecode(res.body)['body']),
          );

          showSnackBar(
            context,
            'Fields updated successfully',
          );
        },
      );
    } catch (e) {
      print(e.toString());
      showSnackBar(context, " error ?? ${e.toString()}");
    }
  }

  void updateFcmToken(
      {required String userid, required String fcmtoken}) async {
    if (userid.isEmpty || fcmtoken.isEmpty) {
      print('userid || fcmtoken is required.');
      return;
    }

    try {
      print("updating fcm token");

      Map<String, String> requestBody = {
        'userid': userid,
        'fcmtoken': fcmtoken,
      };

      http.Response res = await http.post(
          Uri.parse('${Constants.uri}users/update'),
          // body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(requestBody));
      print('Response status: ${res.statusCode}');
      print('Response status: ${res}');
      print('Response body: ${res.body}');
      print('Response real body: ${jsonDecode(res.body)['body']}');

      if (res.statusCode < 300) {
        print("fcm updated successfully");
      } else {
        print("error : ${res.body}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = await prefs.getString("user");
    print("user ");
    print(user);
    if (user == null || user == "") {
      await prefs.setString('user', '');
      User user = User(id: "", phoneNumber: "");
      print("setting to null");
      userProvider.setUserFromModel(user);
    } else {
      userProvider.setUser(jsonDecode(user));
    }
  }

  void SignOut(BuildContext context) async {
    final navigator = Navigator.of(context);

    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString("user");
    print(user);
    await prefs.setString('user', '');
    User usernew = User(id: "", phoneNumber: "");

    userProvider.setUserFromModel(usernew);
    navigator.push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void fetchLocations({
    required BuildContext context,
    required String userid,
  }) async {
    print("fetching location");
    var locationListProvider =
        Provider.of<LocationListProvider>(context, listen: false);
    print(userid);
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}location/get'),
        // body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'userId': userid,
        }),
      );
      print(res.body);
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(res.body);
          locationListProvider.setLocationList(res.body);
        },
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void fetchCategories({
    required BuildContext context,
  }) async {
    print("ffetch");
    var categoryListProvider =
        Provider.of<CategoryListProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}category/getall'),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('Response array: ${jsonEncode(jsonDecode(res.body)['body'])}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          categoryListProvider.setCategoryList(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
    }
    print("ffetch");
  }

  Future<void> fetchRepairRequest({
    required BuildContext context,
    required String userid,
  }) async {
    print("fetching Reapir Requests");
    var repairRequestProvider =
        Provider.of<RepairRequestListProvider>(context, listen: false);
    print(userid);
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}repair_request/get/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'userId': userid,
        }),
      );
      print(res.body);
      print("fetching Reapir Requests");

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(res.body);
          repairRequestProvider.setRepairRequestList(res.body);
          print("done ....................");
        },
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  void _fetchCategories({
    required BuildContext context,
  }) async {
    print("ffetch");
    var categoryListProvider =
        Provider.of<CategoryListProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}category/getall'),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('Response array: ${jsonEncode(jsonDecode(res.body)['body'])}');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          categoryListProvider.setCategoryList(res.body);
        },
      );
    } catch (e) {
      print(e.toString());
    }
    print("ffetch");
  }

  void fetchProductsDatabase({
    required BuildContext context,
  }) async {
    var productListProvider =
        Provider.of<ProductListProvider>(context, listen: false);

    try {
      DatabaseHelper dbHelper = DatabaseHelper();
      List<Map<String, dynamic>> productMaps =
          hardcodedProducts.map((product) => product.toMap()).toList();
      await dbHelper.insertOrUpdateProducts(productMaps);

      productListProvider
          .setProductListFromModel(ProductList(Productlist: hardcodedProducts));
    } catch (e) {
      print(e.toString());
      showSnackBar(context, "Failed to fetch products: ${e.toString()}");
    }
  }

  void fetchProducts({
    required BuildContext context,
  }) async {
    var productListProvider =
        Provider.of<ProductListProvider>(context, listen: false);

    try {
      http.Response res = await http.get(
        Uri.parse('${Constants.uri}product/getall'),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 200) {
        var productsJson = jsonDecode(res.body)['body'] as List<dynamic>;

        // Convert JSON to a List of Maps for SQLite insertion
        List<Map<String, dynamic>> productsList = productsJson.map((product) {
          return {
            'id': product['id'],
            'categoryId': product['categoryId'],
            'companyId': product['companyId'],
            'name': product['name'],
            'image': product['image'],
            'price': product['price'],
            'stock': product['stock'],
            'sizes': jsonEncode(product['sizes']),
            'description': product['description'],
          };
        }).toList();

        DatabaseHelper dbHelper = DatabaseHelper();
        List<Map<String, dynamic>> productMaps =
            hardcodedProducts.map((product) => product.toMap()).toList();
        await dbHelper.insertOrUpdateProducts(productMaps);

        productListProvider.setProductList(res.body);
      } else {
        showSnackBar(context, "Failed to fetch products: ${res.statusCode}");
      }
    } catch (e) {
      print(e.toString());
      showSnackBar(context, "Error: ${e.toString()}");
    }
  }
}
