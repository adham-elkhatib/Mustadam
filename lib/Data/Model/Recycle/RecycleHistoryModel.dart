import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RecycleHistoryModel {
  String id;
  String userId;
  String itemName;
  String category;
  int points;
  DateTime recycledAt;
  String location;
  String imageUrl;

  RecycleHistoryModel({
    required this.id,
    required this.userId,
    required this.itemName,
    required this.category,
    required this.points,
    required this.recycledAt,
    required this.location,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'itemName': itemName,
      'category': category,
      'points': points,
      'recycledAt': recycledAt.toIso8601String(),
      'location': location,
      'imageUrl': imageUrl,
    };
  }

  factory RecycleHistoryModel.fromMap(Map<String, dynamic> map) {
    return RecycleHistoryModel(
      id: map['id'],
      userId: map['userId'],
      itemName: map['itemName'],
      category: map['category'],

      points: map['points'],
      recycledAt:
          map['recycledAt'] is String
              ? DateTime.parse(map['recycledAt'])
              : (map['recycledAt'] as Timestamp).toDate(),
      location: map['location'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecycleHistoryModel.fromJson(String source) =>
      RecycleHistoryModel.fromMap(json.decode(source));
}
