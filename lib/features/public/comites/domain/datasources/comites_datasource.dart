import '../domain.dart';

abstract class ComitesDatasource {
  Future<List<Comite>> getComiteByPage({int limit = 10, int offset = 0});
  Future<Comite> getComiteById(String id);
  Future<List<Comite>> searchComiteByTerm(String term);
  Future<Comite> createUpdateComite(Map<String, dynamic> comiteLike);
}
