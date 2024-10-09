import 'package:dio/dio.dart';
import '/config/config.dart';
import '/features/public/comites/domain/domain.dart';
import '/features/public/comites/infrastructure/infrastructure.dart';

class ComitesDatasourceImp extends ComitesDatasource {
  late final Dio dio;
  final String accessToken;

  ComitesDatasourceImp({required this.accessToken})
      : dio = Dio(BaseOptions(baseUrl: Environment.apiProduccion, headers: {
          'Authorization': 'Bearer $accessToken',
        }));

  @override
  Future<Comite> createUpdateComite(Map<String, dynamic> comiteLike) {
    // TODO: implement createUpdateComite
    throw UnimplementedError();
  }

  @override
  Future<Comite> getComiteById(String id) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/comite/$id?api_key=$key';
      final response = await dio.get(url);
      if (response.statusCode != 200) throw Exception('Comite no encontrado');

      final comiteDetails = ComiteDetailsResponse.fromJson(response.data);
      final Comite comite = ComiteMapper.comiteDetailstoEntity(comiteDetails);
      return comite;
    } catch (e) {
      // Registra el error o manejalo según sea necesario
      print('Error fetching comite: $e');
      // Es posible que quieras lanzar una excepción personalizada o devolver una lista vacía
      // dependiendo de tu estrategia de manejo de errores
      throw Exception('Failed to fetch comite');
    }
  }

  @override
  Future<List<Comite>> getComiteByPage({int limit = 13, int offset = 0}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/comites?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);
      final comitesResponse = ComitesServerResponse.fromJson(response.data);

      final List<Comite> comites = comitesResponse.data
          //Filtrar para que muestre solo los que tienen portada
          //.where((comiteserver) => comiteserver.imagenportada != '')
          .map((comiteServer) => ComiteMapper.comiteToEntity(comiteServer))
          .toList();

      return comites;
    } catch (e) {
      // Manejo de errores
      //print('Error fetching getComiteByPage: $e');
      return []; // O maneja el error de otra manera, como lanzando una excepción
    }
  }

  @override
  Future<List<Comite>> searchComiteByTerm(String term) {
    // TODO: implement searchComiteByTerm
    throw UnimplementedError();
  }
}
