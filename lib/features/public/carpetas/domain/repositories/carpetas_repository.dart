import '../domains.dart';

abstract class CarpetasRepository {
  Future<List<Carpeta>> getCarpetaByPage({
    int limit = 10,
    int offset = 0,
  });

  Future<List<Carpeta>> getCarpetaPublicoByComite({
    required String uuid,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });

  Future<List<Carpeta>> searchCarpetaPublicoComiteByTerm(
    String term, {
    String? comiteSlug,
  });

  Future<Carpeta> createUpdateCarpeta(
    Map<String, dynamic> carpetaLike,
  );
}
