import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:residence_repository/residence_repository.dart';

class FirebaseResidenceRepo implements ResidenceRepo {
  final residenceCollection = FirebaseFirestore.instance.collection('residences');

  Future<List<Residence>> getResidences() async {
    try {
      return await residenceCollection
        .get()
        .then((value) => value.docs.map((e) => 
          Residence.fromEntity(ResidenceEntity.fromDocument(e.data()))
        ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

   Future<void> addResidence(Residence residence) async {
    try {
      await residenceCollection.doc().set(residence.toJson());
      
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addMultipleResidences(List<Residence> residences) async {
    for (var residence in residences) {
      await addResidence(residence);
    }
  }
}