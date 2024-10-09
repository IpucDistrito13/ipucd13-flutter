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
     * 1. CustomTituloSubtitulo: Mostramos titulo o subtitulo
     * 2. CustomSliderHorizontalTextoImagen: Mostramo titulo y imagen
     */
    return SizedBox(
      height: 337, //350
      child: Column(
        children: [
          //Si lo dos son null no mostrar nada, Si uno de los dos tiene datos mostrar
          if (widget.title != null || widget.subTitle != null)
            CustomTituloSubtitulo(
                title: widget.title, subTitle: widget.subTitle),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount: widget.comites.length,
            scrollDirection: Axis.horizontal,
            //Fisicas tanto android como ios
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
