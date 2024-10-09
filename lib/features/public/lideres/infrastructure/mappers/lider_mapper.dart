import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class LiderMapper {
  // Lista los usuarios lideres segun el comite
  static Lider lideresByComite(LideresByComiteServer lideres) => Lider(
        uuid: lideres.uuid,
        nombre: lideres.nombre,
        apellidos: lideres.apellidos,
        celular: lideres.celular,
        tipolider: lideres.tipolider,
        visibleCelular: true,
        congregacion: lideres.congregacion ?? '',
        municipio: lideres.municipio ?? '',
        departamento: lideres.departamento ?? '',
        imagen: (lideres.imagenperfil != '')
            ? '${Environment.apiStorage}/${lideres.imagenperfil}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
      );
}
