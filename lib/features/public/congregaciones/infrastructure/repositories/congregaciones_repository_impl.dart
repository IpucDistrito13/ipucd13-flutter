import '../../domain/datasources/congregaciones_datasource.dart';
import '../../domain/entities/congregacion.dart';
import '../../domain/repositories/congregaciones_repository.dart';

class CongregacionesRepositoriesImpl extends CongregacionesRepository {
  final CongregacionesDatasource datasource;

  CongregacionesRepositoriesImpl(this.datasource);

  @override
  Future<Congregacion> createUpdateCongregacion(
      Map<String, String> congregacionLike) {
    return datasource.createUpdateCongregacion(congregacionLike);
  }

  @override
  Future<List<Congregacion>> getCongregacioByPage(
      {int limit = 10, int offset = 0}) {
    return datasource.getCongregacioByPage(limit: limit, offset: offset);
  }

  @override
  Future<Congregacion> getCongregacionById(String id) {
    return datasource.getCongregacionById(id);
  }

  @override
  Future<List<Congregacion>> searchCongregacionByTerm(String term) {
    return datasource.searchCongregacionByTerm(term);
  }
}
