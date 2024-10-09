import 'package:dio/dio.dart';

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class SlidersDatasourceImpl extends SlidersDatasource {
  late final Dio dio;
  final String accessToken;

  SlidersDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(baseUrl: Environment.apiProduccion, headers: {
          'Authorization': 'Bearer $accessToken',
        }));

  @override
  Future<List<SliderPrincipal>> getSliderByPage(
      {int limit = 10, int offset = 0}) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/sliders?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);
      final slidersResponse = SliderResponse.fromJson(response.data);
      final List<SliderPrincipal> sliders = slidersResponse.data
          .map((sliderServer) => SliderMapper.sliderToEntity(sliderServer))
          .toList();
      return sliders;
    } catch (e) {
      if (e is DioError) {
        print('Error status code: ${e.response?.statusCode}');
        print('Error response data: ${e.response?.data}');
      } else {
        print('Error: $e');
      }
      return [];
    }
  }
}
