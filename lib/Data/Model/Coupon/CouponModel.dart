import 'dart:convert';

class CouponModel {
  String id;
  String name;
  String imageUrl;

  CouponModel({required this.id, required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'imageUrl': imageUrl};
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponModel.fromJson(String source) =>
      CouponModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
