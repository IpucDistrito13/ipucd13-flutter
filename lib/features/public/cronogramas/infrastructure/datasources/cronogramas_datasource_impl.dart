import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class CronogramasDatasourceImpl extends CronogramaDatasource {
  late final Dio dio;
  final String accessToken;

  CronogramasDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiProduccion,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<List<Cronograma>> getEvenntosByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/cronogramas?limit=$limit&offset=$offset&api_key=$key';
      final response = await dio.get(url);
      final cronogramasServer = CronogramaResponse.fromJson(response.data);
      final List<Cronograma> cronogramas = cronogramasServer.data
          .map((cronogramasServer) =>
              CronogramaMapper.cronogramaToEntity(cronogramasServer))
          .toList();
      return cronogramas;
    } on DioException catch (e) {
      print('DioException occurred: ${e.message}');
      // Handle the error (e.g., return an empty list or rethrow)
      return [];
    } catch (e) {
      print('An unexpected error occurred: $e');
      // Handle other types of errors
      return [];
    }
  }
}