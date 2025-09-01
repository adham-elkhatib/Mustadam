import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class BinModel {
  String id;
  String name;
  LatLng latLng;

  BinModel({required this.id, required this.name, required this.latLng});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lat': latLng.latitude,
      'lng': latLng.longitude,
    };
  }

  factory BinModel.fromMap(Map<String, dynamic> map) {
    return BinModel(
      id: map['id'],
      name: map['name'],
      latLng: LatLng(map['lat'], map['lng']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BinModel.fromJson(String source) =>
      BinModel.fromMap(json.decode(source));
}
