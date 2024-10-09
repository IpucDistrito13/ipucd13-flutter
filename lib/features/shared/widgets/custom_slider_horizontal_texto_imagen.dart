import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../public/comites/domain/domain.dart';

class CustomSliderHorizontalTextoImagen extends StatelessWidget {
  final Comite comite;

  const CustomSliderHorizontalTextoImagen({super.key, required this.comite});

  @override
  Widget build(BuildContext context) {
    return CustomTextoImagen(
        nombre: comite.nombre,
        imagenportada: comite.imagenportada,
        route: '/comite/${comite.id}');
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
