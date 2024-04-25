
class UniversityEntity {
  String universityId;
  String name;
  String image;
  String country;
  String description;
  String url;
  String factsheet;

  UniversityEntity({
    required this.universityId,
    required this.name,
    required this.image,
    required this.country,
    required this.description,
    required this.url,
    required this.factsheet,

  });

  Map<String, Object?> toDocument() {
    return {
      'universityId': universityId,
      'name': name,
      'image': image,
      'country': country,
      'description': description,
      'url': url,
      'factsheet': factsheet,
    };
  }

  static UniversityEntity fromDocument(Map<String, dynamic> doc) {
    return UniversityEntity(
      universityId: doc['universityId'],
      name: doc['name'],
      image: doc['image'],
      country: doc['country'],
      description: doc['description'],
      url: doc['url'],
      factsheet: doc['factsheet'],
    );
  }


}