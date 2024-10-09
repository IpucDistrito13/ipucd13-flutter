import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructures.dart';

class EpisodiosDatasourceImpl extends EpisodiosDatasource {
  late final Dio dio;
  final String accessToken;

  EpisodiosDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<Episodio> createUpdateEpisodio(Map<String, dynamic> episodioLike) {
    // TODO: implement createUpdateEpisodio
    throw UnimplementedError();
  }

  @override
  Future<Episodio> getEpisodioById(String id) {
    // TODO: implement getEpisodioById
    throw UnimplementedError();
  }

  @override
  Future<List<Episodio>> getEpisodiosByPage(
      {int limit = 10, offset = 0, String apikey = ''}) {
    // TODO: implement getEpisodiosByPage
    throw UnimplementedError();
  }

  @override
  Future<List<Episodio>> getEpisodiosByPodcast(
      {required String podcastId,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) async {
    final key = Environment.apiKey;
    final url =
        '/v2/episodios/podcast/$podcastId?limit=$limit&offset=$offset&api_key=$key';

    final response = await dio.get(url);
    final episodiosServer = EpisodioByPodcastResponse.fromJson(response.data);

    final List<Episodio> episodios = episodiosServer.data
        .map((episodiosServer) =>
            EpisodioMapper.episodiosByPodcast(episodiosServer))
        .toList();

    return episodios;
  }

  @override
  Future<List<Episodio>> searchEpisodiosByTerm(String term) {
    // TODO: implement searchEpisodiosByTerm
    throw UnimplementedError();
  }
}
