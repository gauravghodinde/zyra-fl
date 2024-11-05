// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Company {
  final String id;
  final String name;
  final String image;

  Company({
    required this.id,
    required this.name,
    required this.image,
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['_id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);
}
