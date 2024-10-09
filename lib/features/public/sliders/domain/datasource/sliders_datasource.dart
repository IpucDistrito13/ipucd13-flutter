import '../domains.dart';

abstract class SlidersDatasource {
  Future<List<SliderPrincipal>> getSliderByPage(
      {int limit = 10, int offset = 0});
}
