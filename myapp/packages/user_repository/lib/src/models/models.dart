import 'dart:ffi';

export 'user.dart';

class MyUser {

  String userId;
  String email;
  String name;
  Float  gpa;
  bool   certificateEnglish;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.gpa,
    required this.certificateEnglish,
  });

}