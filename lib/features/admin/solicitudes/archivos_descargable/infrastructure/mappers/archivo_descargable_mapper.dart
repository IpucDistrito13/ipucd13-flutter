import '/features/admin/solicitudes/archivos_descargable/domain/entities/archivo_descargable.dart';
import '/features/admin/solicitudes/archivos_descargable/infrastructure/models/archivo_descargable_server.dart';

class ArchivoDescargableMapper {
  static ArchivoDescargable archivoDescargableToEntity(
          ArchivoDescargableServer archivo) =>
      ArchivoDescargable(
        uuid: archivo.uuid,
        tipo: archivo.tipo,
        url: archivo.url,
        nombre: archivo.nombre,
        createdAt: archivo.createdAt,
      );
}
