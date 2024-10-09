import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class VideosDatasourceImpl extends VideosDatasource {
  late final Dio dio;
  final String accessToken;

  VideosDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiProduccion,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<Video> createUpdateVideo(Map<String, dynamic> videoLike) {
    // TODO: implement createUpdateVideo
    throw UnimplementedError();
  }

  @override
  Future<Video> getVideoById(String id) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/video/$id?api_key=$key';
      final response = await dio.get(url);

      final videoDetails = VideoDetailsResponse.fromJson(response.data);
      final Video video = VideoMapper.videoDetailsToEntity(videoDetails);
      return video;
    } catch (e) {
      //print('Error fetching getComiteById: $e');
      throw e;
    }
  }

  @override
  Future<List<Video>> getVideosByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) {
    // TODO: implement getVideosByPage
    throw UnimplementedError();
  }

  @override
  Future<List<Video>> searchVideosByTerm(String term) {
    // TODO: implement searchVideosByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Video>> getVideosBySerie(
      {required String serieId,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) async {
    final key = Environment.apiKey;
    final url =
        '/v2/videos/serie/$serieId?limit=$limit&offset=$offset&api_key=$key';

    final response = await dio.get(url);
    final videosServer = VideosBySerieResponse.fromJson(response.data);

    final List<Video> videos = videosServer.data
        .map((videosServer) => VideoMapper.videosBySerie(videosServer))
        .toList();

    return videos;
  }
}
