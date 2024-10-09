import '../../domain/domains.dart';

class SlidersRepositoryImpl extends SlidersRepository {
  final SlidersDatasource datasource;

  SlidersRepositoryImpl(this.datasource);

  @override
  Future<List<SliderPrincipal>> getSliderByPage(
      {int limit = 10, int offset = 0}) {
    return datasource.getSliderByPage(limit: limit, offset: offset);
  }
}
