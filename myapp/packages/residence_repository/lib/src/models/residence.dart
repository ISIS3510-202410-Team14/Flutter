import '../entities/entities.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class Residence {
  String residenceId;
  String name;
  String image;
  String country;
  String address;
  int capacity;
  String url;

  Residence({
    required this.residenceId,
    required this.name,
    required this.image,
    required this.country,
    required this.address,
    required this.capacity,
    required this.url,
  });

  ResidenceEntity toEntity() {
    return ResidenceEntity(
      residenceId: residenceId,
      name: name,
      image: image,
      country: country,
      address: address,
      capacity: capacity,
      url: url,
    );
  }

  static Residence fromEntity(ResidenceEntity entity) {
    return Residence(
      residenceId: entity.residenceId,
      name: entity.name,
      image: entity.image,
      country: entity.country,
      address: entity.address,
      capacity: entity.capacity,
      url: entity.url,
    );
  }

  // Convertir un objeto Residence en un mapa JSON.
  Map<String, dynamic> toJson() => {
    'residenceId': residenceId,
    'name': name,
    'image': image,
    'country': country,
    'address': address,
    'capacity': capacity,
    'url': url,
  };

  // Crear un objeto Residence a partir de un mapa JSON.
  factory Residence.fromJson(Map<String, dynamic> json) {
    return Residence(
      residenceId: json['residenceId'],
      name: json['name'],
      image: json['image'],
      country: json['country'],
      address: json['address'],
      capacity: json['capacity'],
      url: json['url'],
    );
  }
}

Future<List<Residence>> loadResidences(String path) async {
  final jsonString = await rootBundle.loadString(path);
  final List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((json) => Residence.fromJson(json)).toList();
}
