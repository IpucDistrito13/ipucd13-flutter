import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class LideresDatasourceImpl extends LideresDatasource {
  late final Dio dio;
  final String accessToken;

  LideresDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<List<Lider>> createUpdateLideres(Map<String, dynamic> lideresLike) {
    // TODO: implement createUpdateLideres
    throw UnimplementedError();
  }

  @override
  Future<List<Lider>> getLideresByComite({
    required String comiteId,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  }) async {
    try {
      final key = Environment.apiKey;
      final url =
          '/v2/lideres/comite/$comiteId?limit=$limit&offset=$offset&api_key=$key';
      final response = await dio.get(url);
      if (response.statusCode != 200) throw Exception('Lideres no encontrado');

      final lideresServer = LideresByComiteResponse.fromJson(response.data);
      final List<Lider> lideres = lideresServer.data
          .map((lideresServer) => LiderMapper.lideresByComite(lideresServer))
          .toList();

      return lideres;
    } catch (e) {
      // Registra el error o manejalo según sea necesario
      print('Error fetching lider: $e');
      // Es posible que quieras lanzar una excepción personalizada o devolver una lista vacía
      // dependiendo de tu estrategia de manejo de errores
      throw Exception('Failed to fetch lider');
    }
  }

  @override
  Future<List<Lider>> getLideresByPage({int limit = 10, int offset = 0}) {
    // TODO: implement getLideresByPage
    throw UnimplementedError();
  }

  @override
  Future<List<Lider>> searchLiderByTerm(String term) {
    // TODO: implement searchLiderByTerm
    throw UnimplementedError();
  }
}
