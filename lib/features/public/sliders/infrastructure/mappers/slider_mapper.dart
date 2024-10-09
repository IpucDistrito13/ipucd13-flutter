import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class SliderMapper {
  static SliderPrincipal sliderToEntity(SliderServer slider) => SliderPrincipal(
        id: slider.id,
        nombre: slider.nombre,
        imagen: (slider.imagen != '')
            ? '${Environment.apiStorage}/${slider.imagen}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
      );
}
