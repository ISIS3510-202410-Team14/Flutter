import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app.dart';
import 'package:myapp/simple_bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:university_repository/university_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  firestore.settings = Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  Bloc.observer = SimpleBlocObserver();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //var repo = FirebaseUniversityRepo();
  //var universities = await loadUniversities('assets/files/MOCK_DATA.json');
  //for (var university in universities) {
  //  await repo.addUniversity(university);
  //}

  runApp(MyApp(FirebaseUserRepo()));

}