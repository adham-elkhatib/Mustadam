import 'dart:convert';

import 'package:mustadam/Data/Model/User/user_role.dart';

import 'college_enum.dart';

class UserModel {
  String id;
  String email;
  String name;
  UserRole userRole;
  College college;
  int totalPoints;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.userRole,
    required this.college,
    this.totalPoints = 0,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    UserRole? userRole,
    College? college,
    int? totalPoints,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      userRole: userRole ?? this.userRole,
      college: college ?? this.college,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userRole': userRole.index,
      'college': college.index,
      'totalPoints': totalPoints,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      userRole: UserRole.values[map['userRole']],
      college: College.values[map['college']],
      totalPoints: map['totalPoints'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
