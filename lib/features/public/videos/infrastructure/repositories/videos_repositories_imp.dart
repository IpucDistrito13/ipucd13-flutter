import '../../domain/domains.dart';

class VideosRepositoriesImp extends VideosRepository {
  final VideosDatasource datasource;

  VideosRepositoriesImp(this.datasource);

  @override
  Future<Video> createUpdateVideo(Map<String, dynamic> videoLike) {
    return datasource.createUpdateVideo(videoLike);
  }

  @override
  Future<Video> getVideoById(String id) {
    return datasource.getVideoById(id);
  }

  @override
  Future<List<Video>> getVideosByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) {
    return datasource.getVideosByPage(
        limit: limit, offset: offset, apikey: apikey);
  }

  @override
  Future<List<Video>> searchVideosByTerm(String term) {
    return datasource.searchVideosByTerm(term);
  }

  @override
  Future<List<Video>> getVideosBySerie(
      {required String serieId,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getVideosBySerie(serieId: serieId);
  }
}
