import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructures.dart';

class EpisodioMapper {
  static Episodio episodiosByPodcast(EpisodiosByPodcastServer episodios) =>
      Episodio(
        id: episodios.id,
        slug: episodios.slug,
        titulo: episodios.titulo,
        descripcion: episodios.descripcion,
        imagenportada: (episodios.imagenportada != '')
            ? '${Environment.apiStorage}/${episodios.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        url: episodios.url ?? '',
        categoria: episodios.categoria,
      );
}
