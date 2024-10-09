import '../domains.dart';

abstract class SlidersRepository {
  Future<List<SliderPrincipal>> getSliderByPage(
      {int limit = 10, int offset = 0});
}
