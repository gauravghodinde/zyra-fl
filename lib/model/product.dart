// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:core';

class Product {
  final String id;
  final String categoryId;
  final String companyId;
  final String name;
  final String image;
  final int price;
  final String stock;
  final List<String> sizes;
  final String description;

  Product({
    required this.id,
    required this.categoryId,
    required this.companyId,
    required this.name,
    required this.image,
    required this.price,
    required this.stock,
    required this.sizes,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'companyId': companyId,
      'name': name,
      'image': image,
      'price': price,
      'stock': stock,
      'sizes': sizes.join(','),
      'description': description,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      categoryId: map['categoryId'] as String,
      companyId: map['companyId'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as int,
      stock: map['stock'] as String,
      sizes: map['sizes'].split(','),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
