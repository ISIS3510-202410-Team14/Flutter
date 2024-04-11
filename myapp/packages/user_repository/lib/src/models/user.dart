import 'package:user_repository/src/entities/entities.dart';

class MyUser {

  String userId;
  String email;
  String name;
  double  gpa;
  bool   certificateEnglish;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.gpa,
    required this.certificateEnglish,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    name: '',
    gpa: 0.0,
    certificateEnglish: false,
  );

  MyUserEntity toEntity() {

    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      gpa: gpa,
      certificateEnglish: certificateEnglish,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {

    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      gpa: entity.gpa,
      certificateEnglish: entity.certificateEnglish,
    );
  }

  @override
  String toString(){
    return 'MyUser { userId: $userId, email: $email, name: $name, gpa: $gpa, certificateEnglish: $certificateEnglish }';
  }

}