import '/features/admin/solicitudes/archivos_descargable/domain/datasources/archivos_descargable_datasource.dart';
import '/features/admin/solicitudes/archivos_descargable/domain/entities/archivo_descargable.dart';
import '/features/admin/solicitudes/archivos_descargable/domain/repositories/archivos_descargable_repository.dart';

class ArchivosDescargableRepositoryImpl extends ArchivosDescargableRepository {
  final ArchivosDescargableDatasource datasource;

  ArchivosDescargableRepositoryImpl(this.datasource);
  @override
  Future<ArchivoDescargable> createOrUpdateArchivo(
      Map<String, dynamic> archivoDescargableLike) {
    return datasource.createOrUpdateArchivo(archivoDescargableLike);
  }

  @override
  Future<List<ArchivoDescargable>> getSArchivosByPage(
      {int limit = 10, int offset = 0}) {
    return datasource.getSArchivosByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<ArchivoDescargable>> searchArchivosByTerm(String term) {
    return datasource.searchArchivosByTerm(term);
  }
}
