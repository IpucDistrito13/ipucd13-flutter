import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/domains.dart';

class LideresInfoVerticalListview extends StatefulWidget {
  final List<Lider> lideres;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const LideresInfoVerticalListview({
    super.key,
    required this.lideres,
    this.title,
    this.subTitle,
    this.loadNextPage,
  });

  @override
  State<LideresInfoVerticalListview> createState() =>
      _LideresInfoVerticalListviewState();
}

class _LideresInfoVerticalListviewState
    extends State<LideresInfoVerticalListview> {
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
        print('Load next lider info');

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
      height: 315,
      child: Column(
        children: [
          // Si lo dos son null no mostrar nada, Si uno de los dos tiene datos mostrar
          if (widget.title != null || widget.subTitle != null)
            _Title(title: widget.title, subTitle: widget.subTitle),

          // Mostrar el ListView solo si podcasts no está vacío o es null
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.lideres.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(
                  child: _SlideCustom(lider: widget.lideres[index]),
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
  final Lider lider;

  const _SlideCustom({required this.lider});

  @override
  Widget build(BuildContext context) {
    return CustomPrincipalImagenTituloWidget(
      imagen: lider.imagen,
      nombre: lider.nombre,
      apellidos: lider.apellidos,
      tipolider: lider.tipolider,
      celular: lider.celular,
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
                  // print('Subtitle pressed');
                },
                child: Text(subTitle!))
        ],
      ),
    );
  }
}

class CustomPrincipalImagenTituloWidget extends StatefulWidget {
  final String? imagen;
  final String nombre;
  final String apellidos;
  final String tipolider;
  final String celular;
  const CustomPrincipalImagenTituloWidget({
    super.key,
    this.imagen,
    required this.nombre,
    required this.apellidos,
    required this.tipolider,
    required this.celular,
  });
  @override
  State<CustomPrincipalImagenTituloWidget> createState() =>
      _CustomPrincipalImagenTituloState();
}

class _CustomPrincipalImagenTituloState
    extends State<CustomPrincipalImagenTituloWidget> {
  void _showDetailsAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalles del Líder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${widget.nombre}'),
              Text('Apellidos: ${widget.apellidos}'),
              Text('Tipo de Líder: ${widget.tipolider}'),
            ],
          ),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.phone),
                  label: const Text('Llamar'),
                  onPressed: () {
                    launch("tel:${widget.celular}");
                  },
                ),
                const SizedBox(height: 10), // Espacio entre botones
                ElevatedButton.icon(
                  icon: const Icon(Icons.message),
                  label: const Text('WhatsApp'),
                  onPressed: () {
                    launch("https://wa.me/+57${widget.celular}");
                  },
                ),
                const SizedBox(height: 10), // Espacio entre botones
                TextButton(
                  child: const Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 13,
      fontWeight: FontWeight.w400,
    );
    const descripcionStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
    return FadeIn(
      duration: const Duration(milliseconds: 800),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZoomIn(
              duration: const Duration(milliseconds: 800),
              child: SizedBox(
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: _showDetailsAlert,
                    child: FadeInImage(
                      height: 210,
                      fit: BoxFit.cover,
                      placeholder:
                          const AssetImage('assets/gif/gif_cargando3.gif'),
                      image: NetworkImage(widget.imagen ?? ''),
                    ),
                  ),
                ),
              ),
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: SizedBox(
                width: 150,
                child: Text(
                  widget.tipolider,
                  style: descripcionStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: SizedBox(
                width: 150,
                child: Text(
                  '${widget.nombre} ${widget.apellidos}',
                  style: titleStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
