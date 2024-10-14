import 'package:dio/dio.dart';
import 'package:ipucd13_flutter/features/admin/auth/infrastructure/infrastructure.dart';

import '../../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../insfrastructures.dart';

class CarpetasDatasourceImp extends CarpetasDatasource {
  late final Dio dio;
  final String accessToken;

  CarpetasDatasourceImp({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  List<Carpeta> _jsonToCarpeta(Map<String, dynamic> json) {
    final carpetaServerResponse = CarpetasByComiteResponse.fromJson(json);

    final List<Carpeta> carpetas = carpetaServerResponse.data
        //EJEMPLO PARA FILTRAR
        //.where((congregacionesServer) =>
        //    congregacionesServer.direccion != 'PENDIENTE')
        .map((congregacionesServer) =>
            CarpetaMapper.carpetaDetailsToEntity(congregacionesServer))
        .toList();

    return carpetas;
  }

  @override
  Future<Carpeta> createUpdateCarpeta(Map<String, dynamic> carpetaLike) {
    throw UnimplementedError();
  }

  @override
  Future<List<Carpeta>> getCarpetaByPage({int limit = 10, int offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Carpeta>> getCarpetaPrivadoByComite(
      {required String uuid,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/descargable/carpeta/privado/comite/$uuid?api_key=$key';

      final response = await dio.get(url);
      final carpetasServer = CarpetasByComiteResponse.fromJson(response.data);

      final List<Carpeta> carpetas = carpetasServer.data
          .map((carpetasServer) =>
              CarpetaMapper.carpetaDetailsToEntity(carpetasServer))
          .toList();

      return carpetas;
    } on DioException catch (e) {
      //MUESTRA ERROR SEGUN RESPUESTA DEL SERVIDOR
      if (e.response != null) {
        //print(e.response.toString());
        if (e.response?.statusCode == 401) {
          throw CustomError(
              e.response?.data['message'] ?? 'Credenciales incorrectas.');
        }
      } else {
        //print('Error sin respuesta: ${e.type}');
        throw CustomError('Revisar conexión a internet');
      }

      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Carpeta>> searchCarpetaPrivadoComiteByTerm(String term,
      {String? comiteSlug}) async {
    if (term.isEmpty) return [];

    try {
      final key = Environment.apiKey;
      final url =
          '/v2/carpetas/publico/comite/search?comite=$comiteSlug&query=$term&api_key=$key';
      final response = await dio.get(
        url,
        queryParameters: {'query': term},
        options: Options(
          validateStatus: (status) {
            return status! <
                500; // Considera todas las respuestas con status < 500 como válidas
          },
        ),
      );

      if (response.statusCode == 200) {
        return _jsonToCarpeta(response.data);
      } else {
        //print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      if (e is DioError) {
        //print('Error status code: ${e.response?.statusCode}');
        //print('Error response data: ${e.response?.data}');
      } else {
        //print('Error: $e');
      }
      return [];
    }
  }
}
