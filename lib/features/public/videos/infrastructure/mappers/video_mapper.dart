import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class VideoMapper {
  static Video videosBySerie(VideosBySerieServer video) => Video(
        id: video.id,
        slug: video.slug,
        titulo: video.titulo,
        descripcion: video.descripcion ?? '',
        imagenportada: (video.imagenportada != '')
            ? '${Environment.apiStorage}/${video.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        url: video.url ?? 'no-url',
        categoria: video.categoria,
      );

  static Video videoDetailsToEntity(VideoDetailsResponse comiteDetails) =>
      Video(
        id: comiteDetails.data.id,
        slug: comiteDetails.data.slug,
        titulo: comiteDetails.data.nombre,
        descripcion: comiteDetails.data.descripcion ?? '',
        imagenportada: '',
        url: comiteDetails.data.url ?? '',
        categoria: comiteDetails.data.categoria,
      );
}
