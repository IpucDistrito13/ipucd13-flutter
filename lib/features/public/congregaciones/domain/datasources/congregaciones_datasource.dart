import '../domains.dart';

abstract class CongregacionesDatasource {
  Future<List<Congregacion>> getCongregacioByPage(
      {int limit = 10, int offset = 0});

  Future<Congregacion> getCongregacionById(String id);

  Future<List<Congregacion>> searchCongregacionByTerm(String term);

  Future<Congregacion> createUpdateCongregacion(
      Map<String, String> congregacionLike);
}
