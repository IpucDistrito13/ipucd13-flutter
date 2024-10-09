import '/features/admin/galerias/domain/entities/galeria.dart';

abstract class GaleriasRepository {
  Future<List<Galeria>> getGalriaPrivadaByUUid({
    int limit = 10,
    int offset = 0,
  });

  Future<List<Galeria>> getGaleriaPublicaByUsuario({
    required String uuid,
    int limit = 10,
    int offset = 0,
    String apikey = '',
  });
}
