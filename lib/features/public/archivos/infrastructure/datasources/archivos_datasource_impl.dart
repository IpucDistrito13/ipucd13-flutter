import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/datasource/archivos_datasource.dart';
import '../../domain/domains.dart';
import '../infrastructures.dart';

class ArchivosDatasourceImpl extends ArchivosDatasource {
  late final Dio dio;
  final String accessToken;

  ArchivosDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiProduccion,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<List<Archivo>> getArchivosByCarpeta({
    required String uuid,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  }) async {
    try {
      final key = Environment.apiKey;
      final url =
          '/v2/archivo/carpeta/$uuid?limit=$limit&offset=$offset&api_key=$apikey';

      final response = await dio.get(url);
      final archivosServer = ArchivosByCarpetaResponse.fromJson(response.data);

      final List<Archivo> archivos = archivosServer.data
          .map((archivosServer) =>
              ArchivoMapper.archivosDetailsToEntity(archivosServer))
          .toList();

      return archivos;
    } catch (e) {
      print('Error fetching archivos: $e');
      return [];
    }
  }

  @override
  Future<List<Archivo>> getArchivosByPage({int limit = 10, int offset = 0}) {
    // TODO: implement getArchivosByPage
    throw UnimplementedError();
  }

  @override
  Future<Archivo> saveOrUpdateArchivo(Map<String, dynamic> archivoLike) {
    // TODO: implement saveOrUpdateArchivo
    throw UnimplementedError();
  }

  @override
  Future<List<Archivo>> searchArchivosByTerm(String term) {
    // TODO: implement searchArchivosByTerm
    throw UnimplementedError();
  }
}
