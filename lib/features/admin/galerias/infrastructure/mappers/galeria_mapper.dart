import '/config/constants/environment.dart';
import '/features/admin/galerias/domain/entities/galeria.dart';
import '/features/admin/galerias/infrastructure/models/galeria_by_usuario.dart';

class GaleriaMapper {
  static Galeria galeriaByUsuario(GaleriaByUsuarioServer galeriaServer) =>
      Galeria(
        uuid: galeriaServer.uuid,
        imagen: (galeriaServer.imagen != '')
            ? '${Environment.apiStorage}/${galeriaServer.imagen}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        created: galeriaServer.createdAt,
      );
}
