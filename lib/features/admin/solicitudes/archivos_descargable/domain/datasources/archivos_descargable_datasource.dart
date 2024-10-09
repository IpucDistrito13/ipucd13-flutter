import '/features/admin/solicitudes/archivos_descargable/domain/entities/archivo_descargable.dart';

abstract class ArchivosDescargableDatasource {
  Future<List<ArchivoDescargable>> getSArchivosByPage({
    int limit = 10,
    int offset = 0,
  });

  Future<List<ArchivoDescargable>> searchArchivosByTerm(String term);

  Future<ArchivoDescargable> createOrUpdateArchivo(
    Map<String, dynamic> archivoDescargableLike,
  );
}
