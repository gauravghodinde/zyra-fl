import 'package:flutter/material.dart';
import 'package:zyra/model/product.dart';
import 'package:zyra/pages/product/product_detail.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.CategorytName,
    required this.product,
    required this.isgridview,
  });

  final String CategorytName;
  final Product product;
  final bool isgridview;

  @override
  Widget build(BuildContext context) {
    double imageWidth =
        MediaQuery.of(context).size.width / (isgridview ? 2 : 1);
    double ImageHeight =
        MediaQuery.of(context).size.height / ((isgridview) ? 5 : 2);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(
              product: product,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.image,
              width: imageWidth,
              height: ImageHeight,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: imageWidth,
                );
              },
            ),
          ),
          SizedBox(height: 18),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            product.companyId,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            "\Rs. ${product.price.toString()}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              // color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
