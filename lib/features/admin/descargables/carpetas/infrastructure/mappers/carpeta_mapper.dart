import '../../domain/entities/carpetas.dart';
import '../insfrastructures.dart';

class CarpetaMapper {
  static Carpeta carpetaDetailsToEntity(CarpetasByComiteServer carpeta) =>
      Carpeta(
        id: carpeta.id,
        nombre: carpeta.nombre,
        slug: carpeta.slug,
        createdAt: carpeta.createdAt ?? '',
      );
}
