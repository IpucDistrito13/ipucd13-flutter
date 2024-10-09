import '../../domain/domains.dart';
import '../infrastructure.dart';

class CarpetaMapper {
  static Carpeta carpetaDetailsToEntity(CarpetasByComiteServer carpeta) =>
      Carpeta(
        id: carpeta.id,
        nombre: carpeta.nombre,
        slug: carpeta.slug,
        createdAt: carpeta.createdAt ?? '',
      );
}
