import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RewardSummaryModel {
  String id;
  String userId;
  int totalPoints;
  int redeemedPoints;
  DateTime dateTime;

  RewardSummaryModel({
    required this.id,
    required this.userId,
    required this.totalPoints,
    required this.redeemedPoints,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'totalPoints': totalPoints,
      'redeemedPoints': redeemedPoints,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory RewardSummaryModel.fromMap(Map<String, dynamic> map) {
    return RewardSummaryModel(
      id: map['id'],
      userId: map['userId'],
      totalPoints: map['totalPoints'],
      redeemedPoints: map['redeemedPoints'],
      dateTime:
          map['dateTime'] is String
              ? DateTime.parse(map['dateTime'])
              : (map['dateTime'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RewardSummaryModel.fromJson(String source) =>
      RewardSummaryModel.fromMap(json.decode(source));
}
