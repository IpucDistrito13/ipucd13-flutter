import 'package:dio/dio.dart';
import '/config/constants/environment.dart';
import '/features/admin/galerias/domain/datasource/galerias_datasource.dart';
import '/features/admin/galerias/domain/entities/galeria.dart';
import '/features/admin/galerias/infrastructure/mappers/galeria_mapper.dart';
import '/features/admin/galerias/infrastructure/models/galeria_by_usuario.dart';

class GaleriasDatasourceImpl extends GaleriasDatasource {
  late final Dio dio;
  final String accessToken;

  GaleriasDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<List<Galeria>> getGalriaPrivadaByUUid(
      {int limit = 10, int offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Galeria>> getGaleriaPublicaByUsuario({
    required String uuid,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  }) async {
    final key = Environment.apiKey;
    final url =
        '/v2/galeria/publica/$uuid?limit=$limit&offset=$offset&api_key=$key';

    try {
      final response = await dio.get(url);
      final galeriaServer = GaleriaByUsuarioResponse.fromJson(response.data);

      final List<Galeria> galerias = galeriaServer.data
          .map((galeriaServer) => GaleriaMapper.galeriaByUsuario(galeriaServer))
          .toList();

      return galerias;
    } catch (e) {
      if (e is DioException) {
        //print('Dio error occurred: ${e.message}');
        //print('Response data: ${e.response?.data}');
      } else {
        //print('An error occurred: $e');
      }
      return []; 
    }
  }
}
