import 'package:ipucd13_flutter/features/public/archivos/domain/domains.dart';

abstract class ArchivosDatasource {
  Future<List<Archivo>> getArchivosByPage({int limit = 10, int offset = 0});

  Future<List<Archivo>> getArchivosByCarpeta(
      {required String uuid,
      int limit = 10,
      int offset = 0,
      String apikey = ''});

  Future<List<Archivo>> searchArchivosByTerm(String term);

  Future<Archivo> saveOrUpdateArchivo(Map<String, dynamic> archivoLike);
}
