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
  Future<List<Carpeta>> searchCarpetaPublicoComiteByTerm(String term,
      {String? comiteSlug}) {
    return datasource.searchCarpetaPublicoComiteByTerm(term,
        comiteSlug: comiteSlug);
  }

  @override
  Future<List<Carpeta>> getCarpetaPublicoByComite(
      {required String uuid,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getCarpetaPublicoByComite(
        uuid: uuid, limit: limit, offset: offset, apikey: apikey);
  }
}
