import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class CongregacionMapper {
  static Congregacion congregacionesToEntity(CongregacionServer congregacion) =>
      Congregacion(
        id: congregacion.id,
        uuid: congregacion.uuid ?? '',
        congregacion: congregacion.congregacion,
        municipio: congregacion.municipio,
        departamento: congregacion.departamento,
        direccion: congregacion.direccion ?? 'No registrado',
        longitud: congregacion.longitud ?? '',
        latitud: congregacion.latitud ?? '',
        urlfacebook: congregacion.urlfacebook ?? '',
        googlemaps: congregacion.googlemaps ?? '',
        fotocongregacion: (congregacion.fotocongregacion != '')
            ? '${Environment.apiStorage}/${congregacion.fotocongregacion}'
            : '${Environment.apiStorage}/public/No_imagen/imagen_no_found_vertical.webp',
      );
}
