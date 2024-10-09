import '../domains.dart';

abstract class SeriesDatasource {
  Future<List<Serie>> getSeriesByPage(
      {int limit = 10, int offset = 0, String apikey = ''});

  Future<Serie> getSerieById(String id);

  Future<List<Serie>> searchSeriesByTerm(String term);

  Future<Serie> createUpdateSerie(Map<String, dynamic> serieLike);

  Future<List<Serie>> getSerieByComite({
    required String comiteId,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });
}
