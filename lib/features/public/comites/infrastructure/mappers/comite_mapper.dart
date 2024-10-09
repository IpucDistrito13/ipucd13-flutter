import '/config/config.dart';
import '/features/public/comites/domain/domain.dart';
import '/features/public/comites/infrastructure/infrastructure.dart';

class ComiteMapper {
  static Comite comiteToEntity(ComitesServer comite) => Comite(
        id: comite.id,
        slug: comite.slug,
        nombre: comite.nombre,
        descripcion: '',
        imagenportada: (comite.imagenportada != '')
            ? '${Environment.apiStorage}/${comite.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
      );

  static Comite comiteDetailstoEntity(ComiteDetailsResponse comiteDetails) =>
      Comite(
        id: comiteDetails.data.id,
        nombre: comiteDetails.data.nombre,
        slug: comiteDetails.data.slug ?? '',
        descripcion: comiteDetails.data.descripcion,
        imagenportada: (comiteDetails.data.imagenportada != '')
            ? '${Environment.apiStorage}/${comiteDetails.data.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
      );
}
