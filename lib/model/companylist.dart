// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:zyra/model/category.dart';

class Companylist {
  final List<Category> companylist;

  Companylist({required this.companylist});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companylist': companylist.map((x) => x.toMap()).toList(),
    };
  }

  factory Companylist.fromMap(Map<String, dynamic> map) {
    return Companylist(
      companylist: List<Category>.from(
        (map['body'] as List<dynamic>).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Companylist.fromJson(String source) =>
      Companylist.fromMap(json.decode(source) as Map<String, dynamic>);
}
