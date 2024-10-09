import '../domains.dart';

abstract class VideosDatasource {
  Future<List<Video>> getVideosByPage({
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });

  Future<Video> getVideoById(String id);

  Future<List<Video>> searchVideosByTerm(String term);

  Future<Video> createUpdateVideo(Map<String, dynamic> videoLike);

  Future<List<Video>> getVideosBySerie({
    required String serieId,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });
}
