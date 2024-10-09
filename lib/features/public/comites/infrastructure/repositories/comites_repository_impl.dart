import '../../domain/domain.dart';

class ComitesRepositoryImpl extends ComitesRepository {
  final ComitesDatasource datasource;

  ComitesRepositoryImpl(this.datasource);

  @override
  Future<Comite> createUpdateComite(Map<String, dynamic> comiteLike) {
    return datasource.createUpdateComite(comiteLike);
  }

  @override
  Future<Comite> getComiteById(String id) {
    return datasource.getComiteById(id);
  }

  @override
  Future<List<Comite>> getComiteByPage({int limit = 10, int offset = 0}) {
    return datasource.getComiteByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Comite>> searchComiteByTerm(String term) {
    return datasource.searchComiteByTerm(term);
  }
}
