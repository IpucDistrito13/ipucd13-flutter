import 'package:dio/dio.dart';
import '/config/config.dart';
import '/features/public/comites/domain/domain.dart';
import '/features/public/comites/infrastructure/infrastructure.dart';

class ComitesDatasourceImp extends ComitesDatasource {
  late final Dio dio;
  final String accessToken;

  ComitesDatasourceImp({required this.accessToken})
      : dio = Dio(BaseOptions(baseUrl: Environment.apiUrlBackend, headers: {
          'Authorization': 'Bearer $accessToken',
        }));

  @override
  Future<Comite> createUpdateComite(Map<String, dynamic> comiteLike) {
    throw UnimplementedError();
  }

  @override
  Future<Comite> getComiteById(String id) async {
    try {
      final key = Environment.apiKey;
      final url = '/v1/comite/$id?api_key=$key';
      final response = await dio.get(url);
      if (response.statusCode != 200) throw Exception('Comité no encontrado.');

      final comiteDetails = ComiteDetailsResponse.fromJson(response.data);
      final Comite comite = ComiteMapper.comiteDetailstoEntity(comiteDetails);
      return comite;
    } catch (e) {
      throw Exception('Failed to fetch comite');
    }
  }

  @override
  Future<List<Comite>> getComiteByPage({int limit = 10, int offset = 0}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v1/comites?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);

      final comitesResponse = ComitesServerResponse.fromJson(response.data);

      final List<Comite> comites = comitesResponse.data
          //EJEMPLO PARA FILTRAR
          //.where((comiteserver) => comiteserver.imagenportada != '')
          .map((comiteServer) => ComiteMapper.comiteToEntity(comiteServer))
          .toList();

      return comites;
    } catch (e) {
      //MANEJO DE ERRORES
      //print('Error fetching getComiteByPage: $e');
      return [];
    }
  }

  @override
  Future<List<Comite>> searchComiteByTerm(String term) {
    throw UnimplementedError();
  }
}
