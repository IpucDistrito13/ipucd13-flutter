import 'package:dio/dio.dart';
import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class LideresDatasourceImpl extends LideresDatasource {
  late final Dio dio;
  final String accessToken;

  LideresDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrlBackend,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<List<Lider>> createUpdateLideres(Map<String, dynamic> lideresLike) {
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
          '/v1/lideres/comite/$comiteId?limit=$limit&offset=$offset&api_key=$key';
      final response = await dio.get(url);

      if (response.statusCode != 200) throw Exception('Lideres no encontrado');

      final lideresServer = LideresByComiteResponse.fromJson(response.data);
      //print('lideresServer $lideresServer');

      final List<Lider> lideres = lideresServer.data
          .map((lideresServer) => LiderMapper.lideresByComite(lideresServer))
          .toList();

      return lideres;
    } catch (e) {
      //MANEJO DE ERRORES
      //throw Exception('Failed to fetch lider ');
      return [];
    }
  }

  @override
  Future<List<Lider>> getLideresByPage({int limit = 10, int offset = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Lider>> searchLiderByTerm(String term) {
    throw UnimplementedError();
  }
}
