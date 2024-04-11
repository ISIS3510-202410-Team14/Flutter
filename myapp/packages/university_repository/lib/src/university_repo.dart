import 'models/models.dart';

abstract class UniversityRepo {
    Future<List<University>> getUniversitys();

}