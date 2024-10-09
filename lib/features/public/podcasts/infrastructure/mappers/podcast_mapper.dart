// Lista los podcast desde la pantalla principal

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class PodcastMapper {
  static Podcast podcastToEntity(PodcastServer podcast) => Podcast(
        id: podcast.id,
        slug: podcast.slug,
        nombre: podcast.nombre,
        descripcion: '',
        imagenportada: (podcast.imagenportada != '')
            ? '${Environment.apiStorage}/${podcast.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        imagenbanner: '',
        contenido: '',
        categoria: '',
      );

  // Muestra los detalles del podcast
  static Podcast podcastDetailstoEntity(
          PodcastDetailsResponse podcastDetails) =>
      Podcast(
          id: podcastDetails.data.id,
          slug: podcastDetails.data.slug,
          nombre: podcastDetails.data.nombre,
          descripcion: podcastDetails.data.descripcion ?? '',
          imagenbanner: '',
          imagenportada: (podcastDetails.data.imagenportada != '')
              ? '${Environment.apiStorage}/${podcastDetails.data.imagenportada}'
              : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
          contenido: podcastDetails.data.contenido ?? '',
          categoria: podcastDetails.data.categoria ?? '');

  // Lista los podcast desde los detalles del comite
  static Podcast podcastsByComite(PodcastsByComiteServer podcasts) => Podcast(
        id: podcasts.id,
        slug: podcasts.slug,
        nombre: podcasts.nombre,
        descripcion: podcasts.descripcion,
        imagenbanner: '',
        imagenportada: (podcasts.imagenportada != '')
            ? '${Environment.apiStorage}/${podcasts.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        contenido: '',
        categoria: podcasts.categoria,
      );
}
