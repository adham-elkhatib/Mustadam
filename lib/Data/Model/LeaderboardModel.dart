import 'dart:convert';

import 'User/college_enum.dart';

class LeaderboardModel {
  String id;
  College college;
  String imgUrl;
  int points;
  DateTime timestamp;

  LeaderboardModel({
    required this.id,
    required this.imgUrl,
    required this.college,
    required this.points,
    required this.timestamp,
  });

  LeaderboardModel copyWith({
    String? id,
    College? college,
    String? imgUrl,
    int? points,
    DateTime? timestamp,
  }) {
    return LeaderboardModel(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      college: college ?? this.college,
      points: points ?? this.points,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imgUrl': imgUrl,
      'college': college.index,
      'points': points,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory LeaderboardModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardModel(
      id: map['id'],
      imgUrl: map['imgUrl'],
      college: College.values[map['college']],
      points: map['points'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaderboardModel.fromJson(String source) =>
      LeaderboardModel.fromMap(json.decode(source));
}
