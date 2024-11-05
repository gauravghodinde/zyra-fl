import 'package:zyra/components/appbar.dart';
import 'package:zyra/components/productcard.dart';
import 'package:zyra/providers/categoryProvider.dart';
import 'package:zyra/providers/locationProvider.dart';
import 'package:zyra/providers/productProvider.dart';
import 'package:zyra/providers/userProvider.dart';
import 'package:zyra/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userid;
  bool isGridView = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    userid = user.id;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    userid = user.id;
    final _categories = Provider.of<CategoryListProvider>(context).categorylist;
    final _products =
        Provider.of<ProductListProvider>(context).Productlist.Productlist;
    final _location = Provider.of<LocationProvider>(context).loaction;

    AuthService authService = AuthService();
    void _logout() {
      authService.SignOut(context);
    }

    // Filter products based on search query
    final filteredProducts = _products.where((product) {
      final lowerQuery = searchQuery.toLowerCase();
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.companyId.toLowerCase().contains(lowerQuery);
    }).toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            // Location AppBar
            locationAppBar(
              location: _location,
            ),
            // Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search by name or brand...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
            ),
            // Product List (Grid/List View Toggle)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: isGridView
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            CategorytName: filteredProducts[index].categoryId,
                            product: filteredProducts[index],
                            isgridview: isGridView,
                          );
                        },
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ProductCard(
                                  CategorytName:
                                      filteredProducts[index].categoryId,
                                  product: filteredProducts[index],
                                  isgridview: isGridView,
                                ),
                                Divider(),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isGridView = !isGridView; // Toggle between grid and list view
          });
        },
        child: Icon(isGridView ? Icons.view_list : Icons.grid_view),
      ),
    );
  }
}
