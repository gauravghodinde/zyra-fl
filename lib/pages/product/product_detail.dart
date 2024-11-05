import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zyra/components/locationrequest.dart';
import 'package:zyra/components/overlaysnackbar.dart';
import 'package:zyra/model/product.dart';
import 'package:zyra/pages/login/components/custom_button.dart';
import 'package:zyra/pages/login/components/label_textbox.dart';
import 'package:zyra/providers/DeliveryLocationProvider.dart';
import 'package:zyra/providers/locationProvider.dart';
import 'package:zyra/providers/userProvider.dart';
import 'package:zyra/services/auth_services.dart';
import 'package:zyra/utils/utils.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  String? selectedSize = null;
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    final user = Provider.of<UserProvider>(context).user;
    String userid = user.id;
    final _location = Provider.of<LocationProvider>(context).loaction;
    final _deliverylocation =
        Provider.of<DeliveryLocationProvider>(context).loaction;
    final _user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          showOverlayMessage(context, "Added to Cart");
        },
        child: CustomButton(
          width: 1 / 2,
          text: "add to cart",
        ),
      ),
      // backgroundColor: const Color.fromARGB(255, 241, 243, 241)!,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              _location.FlatHouseFloorBuilding == ""
                  ? "select delivery address"
                  : _location.FlatHouseFloorBuilding,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.product.image,
                        width: MediaQuery.of(context).size.width - 1,
                        height: MediaQuery.of(context).size.height / 2,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width - 10,
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LabelTextbox(
                        heading: widget.product.name,
                        subHeading: widget.product.companyId,
                        para: widget.product.description),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        "Rs. ${widget.product.price.toString()}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 8.0, // Space between sizes
                children: widget.product.sizes.map((size) {
                  bool isSelected = size == selectedSize;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSize = size;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey,
                        ),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  LocationRequestCard(
                    type: "Pickup",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
