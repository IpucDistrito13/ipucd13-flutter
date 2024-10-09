import '/features/admin/galerias/domain/datasource/galerias_datasource.dart';
import '/features/admin/galerias/domain/entities/galeria.dart';
import '/features/admin/galerias/domain/repositories/galerias_repository.dart';

class GaleriasRepositoriesImpl extends GaleriasRepository {
  final GaleriasDatasource datasource;
  GaleriasRepositoriesImpl(this.datasource);

  @override
  Future<List<Galeria>> getGaleriaPublicaByUsuario(
      {required String uuid,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getGaleriaPublicaByUsuario(
        uuid: uuid, limit: limit, offset: offset, apikey: apikey);
  }

  @override
  Future<List<Galeria>> getGalriaPrivadaByUUid(
      {int limit = 10, int offset = 0}) {
    return datasource.getGalriaPrivadaByUUid(limit: limit, offset: offset);
  }
}
