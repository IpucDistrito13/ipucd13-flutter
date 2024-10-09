import '../../domain/domains.dart';
import '../infrastructures.dart';

class ArchivoMapper {
  static Archivo archivosDetailsToEntity(ArchivosByCarpetaServer archivo) =>
      Archivo(
        id: archivo.id,
        uuid: archivo.uuid,
        tipo: archivo.tipo,
        url: archivo.url,
        nombre: archivo.nombre,
        createdAt: archivo.createdAt,
        carpeta: archivo.carpeta,
      );
}
