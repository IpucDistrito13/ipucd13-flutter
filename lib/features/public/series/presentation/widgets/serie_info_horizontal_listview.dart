import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../../shared/shared.dart';
import '../../domain/domains.dart';

class SerieInfoHorizontalListview extends StatefulWidget {
  final List<Serie> series;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const SerieInfoHorizontalListview({
    super.key,
    required this.series,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<SerieInfoHorizontalListview> createState() =>
      _PodcatsHorizontalListViewState();
}

class _PodcatsHorizontalListViewState
    extends State<SerieInfoHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      // widget. loadNextPage == null no realice nada
      if (widget.loadNextPage == null) return;

      // Posicicon maxima es superada llamamos la funcion loadnextPage
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        print('Load next podcasts info');

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
    return SizedBox(
      height: 240, //350
      child: Column(
        children: [
          // Si lo dos son null no mostrar nada, Si uno de los dos tiene datos mostrar
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),

          // Mostrar el ListView solo si podcasts no está vacío o es null
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.series.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _SlideCustom(serie: widget.series[index]),
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
  final Serie serie;

  const _SlideCustom({required this.serie});

  @override
  Widget build(BuildContext context) {
    return CustomInfoWidget(
      imagenportada: serie.imagenportada,
      nombre: serie.nombre,
      descripcion: serie.descripcion,
      categoria: serie.categoria,
      route: '/serie/${serie.id}',
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    //final titleStyle = Theme.of(context).textTheme.titleSmall;

    const titleStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 23,
      fontWeight: FontWeight.w500,
    );

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
                //Estilo para el subtitulo
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {
                  print('Subtitle pressed');
                },
                child: Text(subTitle!))
        ],
      ),
    );
  }
}
