import '../../domain/datasource/archivos_datasource.dart';
import '../../domain/domains.dart';

class ArchivosRepositoriesImpl extends ArchivosRepository {
  final ArchivosDatasource datasource;

  ArchivosRepositoriesImpl(this.datasource);

  @override
  Future<List<Archivo>> getArchivosByCarpeta(
      {required String uuid,
      int limit = 10,
      int offset = 0,
      String apikey = ''}) {
    return datasource.getArchivosByCarpeta(
        uuid: uuid, limit: limit, offset: offset, apikey: apikey);
  }

  @override
  Future<List<Archivo>> getArchivosByPage({int limit = 10, int offset = 0}) {
    return datasource.getArchivosByPage(limit: limit, offset: offset);
  }

  @override
  Future<Archivo> saveOrUpdateArchivo(Map<String, dynamic> archivoLike) {
    return datasource.saveOrUpdateArchivo(archivoLike);
  }

  @override
  Future<List<Archivo>> searchArchivosByTerm(String term) {
    return datasource.searchArchivosByTerm(term);
  }
}
