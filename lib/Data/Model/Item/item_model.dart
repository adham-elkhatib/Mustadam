import 'dart:convert';

import 'item_category.dart';

class ItemModel {
  String id;
  String name;
  String description;
  ItemCategory category;
  String imageUrl;
  String contactLink;
  String ownerId;
  String ownerName;

  DateTime timestamp;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.contactLink,
    required this.ownerId,
    required this.ownerName,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category.label,
      'imageUrl': imageUrl,
      'contactLink': contactLink,
      'ownerId': ownerId,
      "ownerName": ownerName,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  ItemModel copyWith({
    String? id,
    String? name,
    String? description,
    ItemCategory? category,
    String? imageUrl,
    String? contactLink,
    String? ownerId,
    String? ownerName,
    DateTime? timestamp,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      contactLink: contactLink ?? this.contactLink,
      ownerId: ownerId ?? this.ownerId,
      ownerName: ownerName ?? this.ownerName,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      ownerName: map["ownerName"],
      description: map['description'],
      category: ItemCategory.fromLabel(map['category']),
      imageUrl: map['imageUrl'],
      contactLink: map['contactLink'],
      ownerId: map['ownerId'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source));
}
