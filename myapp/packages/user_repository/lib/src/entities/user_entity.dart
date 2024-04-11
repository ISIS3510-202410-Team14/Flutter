class MyUserEntity {

  String userId;
  String email;
  String name;
  double  gpa;
  bool   certificateEnglish;

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.gpa,
    required this.certificateEnglish,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'gpa': gpa,
      'certificateEnglish': certificateEnglish,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      gpa: doc['gpa'],
      certificateEnglish: doc['certificateEnglish'],
    );
  }
}