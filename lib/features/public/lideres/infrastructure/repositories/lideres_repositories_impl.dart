import '../../domain/domains.dart';

class LideresRepositoriesImpl extends LideresRepository {
  final LideresDatasource datasource;

  LideresRepositoriesImpl(this.datasource);

  @override
  Future<List<Lider>> createUpdateLideres(Map<String, dynamic> lideresLike) {
    return datasource.createUpdateLideres(lideresLike);
  }

  @override
  Future<List<Lider>> getLideresByPage({int limit = 10, int offset = 0}) {
    return datasource.getLideresByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Lider>> searchLiderByTerm(String term) {
    return datasource.searchLiderByTerm(term);
  }

  @override
  Future<List<Lider>> getLideresByComite(
      {required String comiteId,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getLideresByComite(comiteId: comiteId);
  }
}
