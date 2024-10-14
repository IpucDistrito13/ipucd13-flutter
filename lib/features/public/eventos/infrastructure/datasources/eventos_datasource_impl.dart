import 'package:dio/dio.dart';
import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class EventosDatasourceImpl extends EventosDatasource {
  late final Dio dio;
  final String accessToken;

  EventosDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrlBackend,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<List<Evento>> getEvenntosByPage(
      {int limit = 10, int offset = 0, String apikey = ''}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v1/eventos?limit=$limit&offset=$offset&api_key=$key';
      final response = await dio.get(url);
      final eventosServer = EventoResponse.fromJson(response.data);
      final List<Evento> eventos = eventosServer.data
          .map((eventosServer) => EventoMapper.eventoToEntity(eventosServer))
          .toList();
      return eventos;
    } on DioException catch (e) {
      //print('DioException occurred: ${e.message}');
      return [];
    } catch (e) {
      //print('An unexpected error occurred: $e');
      return [];
    }
  }
}
