import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/widgets.dart';
import '../../domain/entities/podcast.dart';

///
class PodcastHorizontalListview extends StatefulWidget {
  final List<Podcast> podcasts;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const PodcastHorizontalListview({
    super.key,
    required this.podcasts,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<PodcastHorizontalListview> createState() =>
      _PodcastHorizontalListviewState();
}

class _PodcastHorizontalListviewState extends State<PodcastHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      // Posicicon maxima es superada llamamos la funcion loadnextPage
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage?.call();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 1. CustomTituloSubtitulo: Mostramos titulo o subtitulo
     * 2. CustomSliderHorizontalTextoImagen: Mostramo titulo y imagen
     */
    return SizedBox(
      height: 325, //Altura sizedBox
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            CustomTituloSubtitulo(
                title: widget.title, subTitle: widget.subTitle),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.podcasts.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                    child: CustomSliderHorizontalTextoImagen(
                        podcast: widget.podcasts[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

///
class CustomSliderHorizontalTextoImagen extends StatelessWidget {
  final Podcast podcast;

  const CustomSliderHorizontalTextoImagen({super.key, required this.podcast});

  @override
  Widget build(BuildContext context) {
    return CustomTextoImagen(
        nombre: podcast.nombre,
        imagenportada: podcast.imagenportada,
        route: '/podcast/${podcast.id}');
  }
}

class CustomTextoImagen extends StatefulWidget {
  final String imagenportada;

  final String nombre;
  final String? descripcion;
  final String route;
  const CustomTextoImagen({
    super.key,
    required this.imagenportada,
    required this.nombre,
    this.descripcion,
    required this.route,
  });

  @override
  State<CustomTextoImagen> createState() => _CustomPrincipalImagenTituloState();
}

class _CustomPrincipalImagenTituloState extends State<CustomTextoImagen> {
  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    const descripcionStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //IMAGEN
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  //final route = '/comite/${comite.id}';
                  final route = widget.route;
                  //print('Navigating to: $route');
                  context.push(route);
                },
                child: FadeInImage(
                    height: 220,
                    fit: BoxFit.cover,
                    placeholder:
                        const AssetImage('assets/gif/gif_cargando3.gif'),
                    image: NetworkImage(widget.imagenportada)),
              ),
            ),
          ),
          // FIN DE IMAGEN
          //
          //Titulo
          SizedBox(
            width: 150,
            child: Text(
              widget.nombre,
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2, //Maximo 2 lineas
              textAlign: TextAlign.left, // Centra el texto horizontalmente
            ),
          ),

          SizedBox(
            width: 150,
            child: Text(
              widget.descripcion ?? '',
              style: descripcionStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2, //Maximo 2 lineas
              textAlign: TextAlign.center, // Centra el texto horizontalmente
            ),
          ),
        ],
      ),
    );
  }
}
