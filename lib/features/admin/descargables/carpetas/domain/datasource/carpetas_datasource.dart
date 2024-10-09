import '../domains.dart';

//CARPETA PRIVADO
abstract class CarpetasDatasource {
  Future<List<Carpeta>> getCarpetaByPage({
    int limit = 10,
    int offset = 0,
  });

  Future<List<Carpeta>> getCarpetaPrivadoByComite({
    required String uuid,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });

  Future<List<Carpeta>> searchCarpetaPrivadoComiteByTerm(
    String term, {
    String? comiteSlug,
  });

  Future<Carpeta> createUpdateCarpeta(
    Map<String, dynamic> carpetaLike,
  );
}
