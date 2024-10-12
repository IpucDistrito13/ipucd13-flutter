import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';
import '../models/serie_server_response.dart';

class SeriesDatasourceImpl extends SeriesDatasource {
  late final Dio dio;
  final String accessToken;

  SeriesDatasourceImpl({required this.accessToken})
      : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiUrlBackend,
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );

  @override
  Future<Serie> createUpdateSerie(Map<String, dynamic> serieLike) {
    // TODO: implement createUpdateSerie
    throw UnimplementedError();
  }

  @override
  Future<Serie> getSerieById(String id) async {
    try {
      //
      final key = Environment.apiKey;
      final url = '/v1/serie/$id?api_key=$key';
      final response = await dio.get(url);
      final serieDetails = SerieDetailsResponse.fromJson(response.data);
      final Serie serie = SeriesMapper.serieDetailsToEntity(serieDetails);
      return serie;
    } catch (e) {
      //
      throw e;
    }
  }

  @override
  Future<List<Serie>> getSeriesByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v1/series?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);
      final seriesServer = SeriesServerResponse.fromJson(response.data);

      final List<Serie> series = seriesServer.data
          .map((comiteServer) => SeriesMapper.serieToEntity(comiteServer))
          .toList();

      return series;
    } catch (e) {
      // Manejo de errores
      //print('Error fetching comites: $e');
      return []; // O maneja el error de otra manera, como lanzando una excepción
    }
  }

  @override
  Future<List<Serie>> searchSeriesByTerm(String term) {
    // TODO: implement searchSeriesByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Serie>> getSerieByComite(
      {required String comiteId,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) async {
    final key = Environment.apiKey;
    final url =
        '/v1/series/comite/$comiteId?limit=$limit&offset=$offset&api_key=$key';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final seriesServer = SeriesByComiteResponse.fromJson(response.data);

        final List<Serie> series = seriesServer.data
            .map((seriesServer) => SeriesMapper.seriesByComite(seriesServer))
            .toList();

        return series;
      } else {
        // Maneja el caso en el que la respuesta no es exitosa
        throw Exception('Error al obtener las series: ${response.statusCode}');
      }
    } catch (e) {
      // Maneja cualquier excepción ocurrida durante la solicitud o el procesamiento
      //print('Exception caught: $e');
      //throw Exception('Error al obtener las series: $e');
      return []; // O maneja el error de otra manera, como lanzando una excepción
    }
  }
}
