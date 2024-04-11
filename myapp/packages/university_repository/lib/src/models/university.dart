import '../entities/entities.dart';

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
}