import 'dart:convert';

import 'package:zyra/pages/home/HomeScreen.dart';

import 'package:zyra/providers/RepairReqestProvider.dart';
import 'package:zyra/providers/categoryProvider.dart';
import 'package:zyra/providers/locationListProvider.dart';
import 'package:zyra/providers/locationProvider.dart';
import 'package:zyra/providers/productProvider.dart';
import 'package:zyra/providers/userProvider.dart';
import 'package:zyra/services/auth_services.dart';
import 'package:zyra/utils/constants.dart';
import 'package:zyra/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  bool _stretch = true;
  bool _isLoading = true;
  late String userid;
  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    userid = user.id;
    authService.fetchProductsDatabase(context: context);
    // authService.fetchCategories(context: context);
    // authService.fetchProducts(context: context);
    // authService.fetchLocations(context: context, userid: userid);
  }

  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    userid = user.id;

    AuthService authService = AuthService();

    void _logout() {
      authService.SignOut(context);
    }

    print(_currentIndex);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: _screens[_currentIndex]);
  }
}
