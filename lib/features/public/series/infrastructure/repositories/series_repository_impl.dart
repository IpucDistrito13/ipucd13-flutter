import '../../domain/domains.dart';

class SeriesRepositoriesImp extends SeriesRepository {
  final SeriesDatasource datasource;

  SeriesRepositoriesImp(this.datasource);

  @override
  Future<Serie> createUpdateSerie(Map<String, dynamic> serieLike) {
    return datasource.createUpdateSerie(serieLike);
  }

  @override
  Future<Serie> getSerieById(String id) {
    return datasource.getSerieById(id);
  }

  @override
  Future<List<Serie>> getSeriesByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) {
    return datasource.getSeriesByPage(
        limit: limit, offset: offset, apikey: apikey);
  }

  @override
  Future<List<Serie>> searchSeriesByTerm(String term) {
    return datasource.searchSeriesByTerm(term);
  }

  @override
  Future<List<Serie>> getSerieByComite(
      {required String comiteId,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getSerieByComite(comiteId: comiteId);
  }
}
