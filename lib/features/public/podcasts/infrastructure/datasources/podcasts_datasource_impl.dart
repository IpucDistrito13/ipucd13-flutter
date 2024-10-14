import 'package:dio/dio.dart';
import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class PodcastsDatasourceImpl extends PodcastsDatasource {
  late final Dio dio;
  final String accessToken;

  PodcastsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrlBackend,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<Podcast> createUpdatePodcast(Map<String, dynamic> podcastLike) {
    throw UnimplementedError();
  }

  @override
  Future<Podcast> getPodcastById(String id) async {
    try {
      final key = Environment.apiKey;
      final url = '/v1/podcast/$id?api_key=$key';
      final response = await dio.get(url);
      final podcastDetails = PodcastDetailsResponse.fromJson(response.data);
      final Podcast podcast =
          PodcastMapper.podcastDetailstoEntity(podcastDetails);
      return podcast;
    } catch (e) {
      //MANEJO DE ERRORES
      throw Exception('Failed to fetch podcast');
    }
  }

  @override
  Future<List<Podcast>> getPodcastsByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) async {
    try {
      final key = Environment.apiKey;
      //final url = '/v2/podcasts?limit=$limit&offset=$offset&api_key=$key';
      final url = '/v1/podcasts?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);
      final podcastsServer = PodcastResponse.fromJson(response.data);
      final List<Podcast> podcasts = podcastsServer.data
          .map(
              (podcastsServer) => PodcastMapper.podcastToEntity(podcastsServer))
          .toList();
      return podcasts;
    } on DioException catch (e) {
      //print('DioException occurred: ${e.message}');
      return [];
    } catch (e) {
      //print('An unexpected error occurred: $e');
      return [];
    }
  }

  @override
  Future<List<Podcast>> searchPodcastByTerm(String term) {
    throw UnimplementedError();
  }

  @override
  Future<List<Podcast>> getPodcastByComite({
    required String comiteId,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  }) async {
    try {
      final key = Environment.apiKey;
      final url =
          '/v1/podcasts/comite/$comiteId?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);
      //print('URL podcast by comite: $response');

      final podcastsServer = PodcastsByComiteResponse.fromJson(response.data);
      final List<Podcast> podcasts = podcastsServer.data
          .map((podcastsServer) =>
              PodcastMapper.podcastsByComite(podcastsServer))
          .toList();

      return podcasts;
    } catch (e) {
      // Log the error or handle it as needed
      print('Error fetching - No existe podcasts by comite: $e');
      return [];
    }
  }
}
