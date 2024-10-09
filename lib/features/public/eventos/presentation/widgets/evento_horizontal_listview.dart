import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/domains.dart';
import 'widgets.dart';

class EventoHorizontalListView extends StatefulWidget {
  final List<Evento> eventos;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const EventoHorizontalListView({
    super.key,
    required this.eventos,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<EventoHorizontalListView> createState() =>
      _EventoHorizontalListViewState();
}

class _EventoHorizontalListViewState extends State<EventoHorizontalListView> {
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
            itemCount: widget.eventos.length,
            scrollDirection: Axis.horizontal,
            //Fisicas tanto android como ios
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FadeInRight(
                  child: _SlideCustom(
                evento: widget.eventos[index],
              ));
            },
          ))
        ],
      ),
    );
  }
}

class _SlideCustom extends StatelessWidget {
  final Evento evento;

  const _SlideCustom({required this.evento});

  @override
  Widget build(BuildContext context) {
    return CustomEventos(
        nombre: evento.nombre,
        fecha: DateFormat('yyyy-MM-dd').format(evento.start),
        route: '/eventos');
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
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
