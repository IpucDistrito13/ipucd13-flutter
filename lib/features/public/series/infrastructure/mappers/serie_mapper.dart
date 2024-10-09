// Lista las series desde la pantalla principal

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructure.dart';

class SeriesMapper {
  static Serie serieToEntity(SerieServer serieserver) => Serie(
        id: serieserver.id,
        slug: '',
        nombre: serieserver.nombre,
        descripcion: '',
        contenido: '',
        imagenportada: (serieserver.imagenportada != '')
            ? '${Environment.apiStorage}/${serieserver.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        categoria: '',
      );

  // Muestra los detalles de la serie
  static Serie serieDetailsToEntity(SerieDetailsResponse serieDetails) => Serie(
        id: serieDetails.data.id,
        slug: serieDetails.data.slug,
        nombre: serieDetails.data.nombre,
        descripcion: serieDetails.data.descripcion ?? '',
        contenido: serieDetails.data.contenido ?? '',
        imagenportada: (serieDetails.data.imagenportada != '')
            ? '${Environment.apiStorage}/${serieDetails.data.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        categoria: serieDetails.data.categoria,
      );

  //Lista las series desde los detalles del comite
  static Serie seriesByComite(SeriesByComiteServer series) => Serie(
        id: series.id,
        slug: series.slug,
        nombre: series.nombre,
        descripcion: series.descripcion,
        imagenportada: (series.imagenportada != '')
            ? '${Environment.apiStorage}/${series.imagenportada}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        contenido: '',
        categoria: series.categoria,
      );
}
