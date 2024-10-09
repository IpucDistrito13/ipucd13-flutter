import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class PodcastsDatasourceImpl extends PodcastsDatasource {
  late final Dio dio;
  final String accessToken;

  PodcastsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<Podcast> createUpdatePodcast(Map<String, dynamic> podcastLike) {
    // TODO: implement createUpdatePodcast
    throw UnimplementedError();
  }

  @override
  Future<Podcast> getPodcastById(String id) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/podcast/$id?api_key=$key';
      final response = await dio.get(url);
      final podcastDetails = PodcastDetailsResponse.fromJson(response.data);
      final Podcast podcast =
          PodcastMapper.podcastDetailstoEntity(podcastDetails);
      return podcast;
    } catch (e) {
      // Registra el error o manejalo según sea necesario
      print('Error fetching podcast: $e');
      // Es posible que quieras lanzar una excepción personalizada o devolver una lista vacía
      // dependiendo de tu estrategia de manejo de errores
      throw Exception('Failed to fetch podcast');
    }
  }

  @override
  Future<List<Podcast>> getPodcastsByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/podcasts?limit=$limit&offset=$offset&api_key=$key';
      final response = await dio.get(url);
      final podcastsServer = PodcastResponse.fromJson(response.data);
      final List<Podcast> podcasts = podcastsServer.data
          .map(
              (podcastsServer) => PodcastMapper.podcastToEntity(podcastsServer))
          .toList();
      return podcasts;
    } on DioException catch (e) {
      print('DioException occurred: ${e.message}');
      // Handle the error (e.g., return an empty list or rethrow)
      return [];
    } catch (e) {
      print('An unexpected error occurred: $e');
      // Handle other types of errors
      return [];
    }
  }

  @override
  Future<List<Podcast>> searchPodcastByTerm(String term) {
    // TODO: implement searchPodcastByTerm
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
          '/v2/podcasts/comite/$comiteId?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);

      final podcastsServer = PodcastsByComiteResponse.fromJson(response.data);
      final List<Podcast> podcasts = podcastsServer.data
          .map((podcastsServer) =>
              PodcastMapper.podcastsByComite(podcastsServer))
          .toList();

      return podcasts;
    } catch (e) {
      // Log the error or handle it as needed
      print('Error fetching podcasts: $e');
      // You might want to throw a custom exception or return an empty list
      // depending on your error handling strategy
      throw Exception('Failed to fetch podcasts');
    }
  }
}
