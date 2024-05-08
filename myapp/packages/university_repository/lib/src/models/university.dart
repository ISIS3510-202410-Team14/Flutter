import '../entities/entities.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class University {
  String universityId;
  String name;
  String image;
  String country;
  String description;
  String url;
  String factsheet;

  University({
    required this.universityId,
    required this.name,
    required this.image,
    required this.country,
    required this.description,
    required this.url,
    required this.factsheet,

  });

  UniversityEntity toEntity() {
    return UniversityEntity(
      universityId: universityId,
      name: name,
      image: image,
      country: country,
      description: description,
      url: url,
      factsheet: factsheet,
    );
  }

  static University fromEntity(UniversityEntity entity) {
    return University(
      universityId: entity.universityId,
      name: entity.name,
      image: entity.image,
      country: entity.country,
      description: entity.description,
      url: entity.url,
      factsheet: entity.factsheet,
    );
  }

    // Convertir un objeto University en un mapa JSON.
  Map<String, dynamic> toJson() => {
    'universityId': universityId,
    'name': name,
    'image': image,
    'country': country,
    'description': description,
    'url': url,
    'factsheet': factsheet,
  };

  // Crear un objeto University a partir de un mapa JSON.
  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      universityId: json['universityId'],
      name: json['name'],
      image: json['image'],
      country: json['country'],
      description: json['description'],
      url: json['url'],
      factsheet: json['factsheet'],
    );
  }
}

Future<List<University>> loadUniversities(String path) async {
  final jsonString = await rootBundle.loadString(path);
  final List<dynamic> jsonResponse = json.decode(jsonString);
  return jsonResponse.map((json) => University.fromJson(json)).toList();
}