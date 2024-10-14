import '../../../../shared/shared.dart';
import '../../domain/domains.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class VideoInfoHorizontalListviewWidget extends StatefulWidget {
  final List<Video> videos;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const VideoInfoHorizontalListviewWidget({
    super.key,
    required this.videos,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<VideoInfoHorizontalListviewWidget> createState() =>
      _PodcatsHorizontalListViewState();
}

class _PodcatsHorizontalListViewState
    extends State<VideoInfoHorizontalListviewWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        //print('Cargando nuevos videos info');

        widget.loadNextPage!();
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
     * 1. CustomTituloSubtitulo: MOSTRAMOS TITULO O SUBTITULO
     * 2. CustomSliderHorizontalTextoImagen: MOSTRAMOS TITULO Y IMAGEN
     */
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          //SI LOS DOS SON null NO MOSTRAR NADA, CUANDO TIENE DATOS UNO DE LOS DOS MOSTRAR
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),
            
          //MOSTRAR EL ListView, CUANDO SI EXISTE DATOS
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.videos.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _SlideCustom(video: widget.videos[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideCustom extends StatelessWidget {
  final Video video;

  const _SlideCustom({required this.video});

  @override
  Widget build(BuildContext context) {
    final videoId = video.url;
    final imgPortadaYoutube =
        'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

    return CustomInfoWidget(
      imagenportada: imgPortadaYoutube,
      nombre: video.titulo,
      descripcion: video.descripcion,
      categoria: video.categoria,
      route: '/video/${video.url}',
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 23,
      fontWeight: FontWeight.w500,
    );

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
              onPressed: () {
                //print('Subtitle pressed');
              },
              child: Row(
                children: [
                  Text(subTitle!),
                  const SizedBox(width: 5),
                  const Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
