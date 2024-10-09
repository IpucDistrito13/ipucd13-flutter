import '../../domain/domains.dart';

class CarpetasRepositoriesImpl extends CarpetasRepository {
  final CarpetasDatasource datasource;

  CarpetasRepositoriesImpl(this.datasource);

  @override
  Future<Carpeta> createUpdateCarpeta(Map<String, dynamic> carpetaLike) {
    return datasource.createUpdateCarpeta(carpetaLike);
  }

  @override
  Future<List<Carpeta>> getCarpetaByPage({int limit = 10, int offset = 0}) {
    return datasource.getCarpetaByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Carpeta>> searchCarpetaPrivadoComiteByTerm(String term,
      {String? comiteSlug}) {
    return datasource.searchCarpetaPrivadoComiteByTerm(term,
        comiteSlug: comiteSlug);
  }

  @override
  Future<List<Carpeta>> getCarpetaPrivadoByComite(
      {required String uuid,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getCarpetaPrivadoByComite(
        uuid: uuid, limit: limit, offset: offset, apikey: apikey);
  }
}
