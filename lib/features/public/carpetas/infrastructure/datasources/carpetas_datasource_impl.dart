import 'package:dio/dio.dart';
import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

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
  Future<List<Carpeta>> getCarpetaPublicoByComite(
      {required String uuid,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/descargable/carpeta/publico/comite/$uuid?api_key=$key';

      final response = await dio.get(url);
      final carpetasServer = CarpetasByComiteResponse.fromJson(response.data);

      final List<Carpeta> carpetas = carpetasServer.data
          .map((carpetasServer) =>
              CarpetaMapper.carpetaDetailsToEntity(carpetasServer))
          .toList();

      return carpetas;
    } catch (e) {
      //print('Error fetching carpetas: $e');
      return []; 
    }
  }

  @override
  Future<List<Carpeta>> searchCarpetaPublicoComiteByTerm(String term,
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
                500; 
          },
        ),
      );

      if (response.statusCode == 200) {
        return _jsonToCarpeta(response.data);
      } else {
        print('Request failed with status: ${response.statusCode}');
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
