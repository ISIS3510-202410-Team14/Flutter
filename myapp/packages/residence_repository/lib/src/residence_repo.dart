import 'models/models.dart';

abstract class ResidenceRepo {
    Future<List<Residence>> getResidences();

}