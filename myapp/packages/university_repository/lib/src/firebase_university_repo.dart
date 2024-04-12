import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_repository/university_repository.dart';

class FirebaseUniversityRepo implements UniversityRepo {
  final universityCollection = FirebaseFirestore.instance.collection('universities');

  Future<List<University>> getUniversitys() async {
    try {
      return await universityCollection
        .get()
        .then((value) => value.docs.map((e) => 
          University.fromEntity(UniversityEntity.fromDocument(e.data()))
        ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}