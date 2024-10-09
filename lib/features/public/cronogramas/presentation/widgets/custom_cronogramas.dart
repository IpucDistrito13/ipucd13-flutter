import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCronogramas extends StatefulWidget {
  //final String? imagenportada;
  final String nombre;
  final String fecha;
  final String route;

  const CustomCronogramas(
      {super.key,
      //this.imagenportada,
      required this.nombre,
      required this.fecha,
      required this.route});

  @override
  State<CustomCronogramas> createState() => _CustomCronogramasState();
}

class _CustomCronogramasState extends State<CustomCronogramas> {
  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //IMAGEN
          SizedBox(
            width: 140,
            child: Stack(
              alignment: Alignment.center, // Centrar el texto sobre la imagen
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () {
                      final route = widget.route;
                      context.push(route);
                    },
                    child: FadeInRight(
                      child: Image.asset(
                        'assets/images/fondo_azul_oscuro.png',
                        width: 150,
                        //height: 150,
                        fit: BoxFit
                            .cover, // Para que la imagen llene completamente el espacio
                      ),
                    ),
                  ),
                ),
                // Título sobre la imagen
                Positioned(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.black.withOpacity(
                        0.5), // Fondo oscuro semitransparente para mejor legibilidad
                    child: Text(
                      widget.nombre,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4, // Maximo 2 lineas
                    ),
                  ),
                ),
              ],
            ),
          ),
          //

          //Titulo evento debajo de la imagen
          SizedBox(
            width: 150,
            child: Text(
              widget.fecha,
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 3, //Maximo 2 lineas
              textAlign: TextAlign.center, // Alinea el texto a la izquierda
            ),
          ),

          /*
          SizedBox(
            width: 150,
            child: Text(
              widget.fecha ?? '',
              style: descripcionStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 2, //Maximo 2 lineas
              textAlign: TextAlign.center, // Alinea el texto horizontalmente
            ),
          ),
          */
        ],
      ),
    );
  }
}
