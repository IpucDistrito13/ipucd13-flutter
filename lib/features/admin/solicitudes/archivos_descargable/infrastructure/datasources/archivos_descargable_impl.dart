import 'package:dio/dio.dart';
import '/config/constants/environment.dart';
import '/features/admin/solicitudes/archivos_descargable/domain/datasources/archivos_descargable_datasource.dart';
import '/features/admin/solicitudes/archivos_descargable/domain/entities/archivo_descargable.dart';
import '/features/admin/solicitudes/archivos_descargable/infrastructure/mappers/archivo_descargable_mapper.dart';
import '/features/admin/solicitudes/archivos_descargable/infrastructure/models/archivo_response.dart';

class ArchivosDescargableImpl extends ArchivosDescargableDatasource {
  late final Dio dio;
  final String accessToken;

  ArchivosDescargableImpl({required this.accessToken})
      : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiProduccion,
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );

  @override
  Future<ArchivoDescargable> createOrUpdateArchivo(
      Map<String, dynamic> archivoDescargableLike) {
    // TODO: implement createOrUpdateArchivo
    throw UnimplementedError();
  }

  @override
  Future<List<ArchivoDescargable>> getSArchivosByPage(
      {int limit = 10, int offset = 0}) async {
    try {
      final key = Environment.apiKey;
      final url =
          '/v2/solicitudes/descargable/archivos?limit=$limit&offset=$offset&api_key=$key';
      final response = await dio.get(url);
      final archivosSolicitudServer =
          ArchivosDescargableResponse.fromJson(response.data);

      final List<ArchivoDescargable> archivosDescargable =
          archivosSolicitudServer.data
              .map((solicitudServer) =>
                  ArchivoDescargableMapper.archivoDescargableToEntity(
                      solicitudServer))
              .toList();

      return archivosDescargable;
    } catch (e) {
      print('An unexpected error occurred: $e');
      // Handle other types of errors
      return [];
    }
  }

  @override
  Future<List<ArchivoDescargable>> searchArchivosByTerm(String term) {
    // TODO: implement searchArchivosByTerm
    throw UnimplementedError();
  }
}
