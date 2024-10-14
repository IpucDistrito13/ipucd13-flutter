import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../domain/domain.dart';

///
class ComiteHorizontalListview extends StatefulWidget {
  final List<Comite> comites;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const ComiteHorizontalListview(
      {super.key,
      required this.comites,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<ComiteHorizontalListview> createState() =>
      _ComiteHorizontalListviewState();
}

class _ComiteHorizontalListviewState extends State<ComiteHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      // widget. loadNextPage == null no realice nada
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
     * 1. CustomTituloSubtitulo: MOSTRAMOS TITULO O SUBTITULO
     * 2. CustomSliderHorizontalTextoImagen: MOSTRAMOS TITULO Y IMAGEN
     */
    return SizedBox(
      height: 337, //350
      child: Column(
        children: [
          //SI LOS DOS SON null NO MOSTRAR NADA, CUANDO TIENE DATOS UNO DE LOS DOS MOSTRAR
          if (widget.title != null || widget.subTitle != null)
            CustomTituloSubtitulo(
                title: widget.title, subTitle: widget.subTitle),

          //MOSTRAR EL ListView, CUANDO SI EXISTE DATOS
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount: widget.comites.length,
            scrollDirection: Axis.horizontal,
            //FISICAS TANTO ANDROID COMO IOS
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeInRight(
                  child: CustomSliderHorizontalTextoImagen(
                      comite: widget.comites[index]));
            },
          ))
        ],
      ),
    );
  }
}
