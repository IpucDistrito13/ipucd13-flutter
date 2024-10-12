import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

class CronogramaHorizontalListView extends StatefulWidget {
  final List<Cronograma> cronogramas;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const CronogramaHorizontalListView({
    super.key,
    required this.cronogramas,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<CronogramaHorizontalListView> createState() =>
      _CronogramaHorizontalListViewState();
}

class _CronogramaHorizontalListViewState
    extends State<CronogramaHorizontalListView> {
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
        //print('Load next comites');

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
      height: 270, //350
      child: Column(
        children: [
          //Si lo dos son null no mostrar nada, Si uno de los dos tiene datos mostrar
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            itemCount: widget.cronogramas.length,
            scrollDirection: Axis.horizontal,
            //Fisicas tanto android como ios
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeInRight(
                  child: _SlideCustom(
                cronograma: widget.cronogramas[index],
              ));
            },
          ))
        ],
      ),
    );
  }
}

class _SlideCustom extends StatelessWidget {
  final Cronograma cronograma;

  const _SlideCustom({required this.cronograma});

  @override
  Widget build(BuildContext context) {
    return CustomCronogramas(
        nombre: cronograma.nombre,
        fecha: DateFormat('yyyy-MM-dd').format(cronograma.start),
        route: '/cronogramas');
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
                  //print('Subtitle pressed');
                },
                child: Text(subTitle!))
        ],
      ),
    );
  }
}
