class ResidenceEntity {
  String residenceId;
  String name;
  String image;
  String country;  
  String address;
  int capacity;
  String url;

  ResidenceEntity({
    required this.residenceId,
    required this.name,
    required this.image,
    required this.country,
    required this.address,
    required this.capacity,
    required this.url,
  });

  Map<String, Object?> toDocument() {
    return {
      'residenceId': residenceId,
      'name': name,
      'image': image,
      'country': country,
      'address': address,
      'capacity': capacity,
      'url': url,
    };
  }

  static ResidenceEntity fromDocument(Map<String, dynamic> doc) {
    return ResidenceEntity(
      residenceId: doc['residenceId'],
      name: doc['name'],
      image: doc['image'],
      country: doc['country'],
      address: doc['address'],
      capacity: doc['capacity'],
      url: doc['url'],
    );
  }
}
