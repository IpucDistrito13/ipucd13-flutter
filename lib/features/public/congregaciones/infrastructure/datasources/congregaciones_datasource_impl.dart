import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/datasources/congregaciones_datasource.dart';
import '../../domain/entities/congregacion.dart';
import '../mappers/congregacion_mapper.dart';
import '../models/congregacion_server.dart';

class CongregacionesDatasourceImpl extends CongregacionesDatasource {
  late final Dio dio;
  final String accessToken;

  CongregacionesDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiProduccion,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  List<Congregacion> _jsonToCongregacion(Map<String, dynamic> json) {
    final congregacionServerResponse =
        CongregacionesServerResponse.fromJson(json);

    final List<Congregacion> congregaciones = congregacionServerResponse.data
        .where((congregacionesServer) =>
            congregacionesServer.direccion != 'PENDIENTE')
        .map((congregacionesServer) =>
            CongregacionMapper.congregacionesToEntity(congregacionesServer))
        .toList();

    return congregaciones;
  }

  @override
  Future<Congregacion> createUpdateCongregacion(
      Map<String, String> congregacionLike) {
    // TODO: implement createUpdateCongregacion
    throw UnimplementedError();
  }

  @override
  Future<List<Congregacion>> getCongregacioByPage(
      {int limit = 10, int offset = 0}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/congregaciones?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return _jsonToCongregacion(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      if (e is DioError) {
        print('Error status code: ${e.response?.statusCode}');
        print('Error response data: ${e.response?.data}');
      } else {
        print('Error: $e');
      }
      return [];
    }
  }

  @override
  Future<Congregacion> getCongregacionById(String id) {
    // TODO: implement getCongregacionById
    throw UnimplementedError();
  }

  @override
  Future<List<Congregacion>> searchCongregacionByTerm(String term) async {
    if (term.isEmpty) return [];

    try {
      final key = Environment.apiKey;
      final url = '/v2/congregaciones/search?api_key=$key';

      final response = await dio.get(
        url,
        queryParameters: {'query': term},
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        return _jsonToCongregacion(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      if (e is DioError) {
        print('Error status code: ${e.response?.statusCode}');
        print('Error response data: ${e.response?.data}');
      } else {
        print('Error: $e');
      }
      return [];
    }
  }
}
