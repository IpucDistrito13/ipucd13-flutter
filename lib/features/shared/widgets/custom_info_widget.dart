import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class CustomInfoWidget extends StatefulWidget {
  final String? imagenportada;

  final String nombre;
  final String? descripcion;
  final String? categoria;
  final String route;
  final String? url;
  const CustomInfoWidget({
    super.key,
    this.imagenportada,
    required this.nombre,
    this.descripcion,
    required this.categoria,
    required this.route,
    this.url,
  });

  @override
  State<CustomInfoWidget> createState() => _CustomPrincipalImagenTituloState();
}

class _CustomPrincipalImagenTituloState extends State<CustomInfoWidget> {
  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 17,
      fontWeight: FontWeight.w500,
    );

    const subtitleStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 13,
      fontWeight: FontWeight.w600,
    );

    const descripcionStyle = TextStyle(
      fontFamily: 'MyriamPro',
      fontSize: 15,
      fontWeight: FontWeight.w400,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //IMAGEN
              SizedBox(
                width: 110,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.imagenportada ?? '',
                    //AUN CUANDO CARGUE TENGA EL ESPACIO ASIGNADO
                    width: 100,
                    //fit: BoxFit.cover,

                    //CUANDO SE CONSTRUYA O CARGAMOS EJECUTAMOS
                    loadingBuilder: (context, child, loadingProgress) {
                      //CUANDO ESTA CARGANDO
                      if (loadingProgress != null) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      return GestureDetector(
                        onTap: () {
                          final videoId = widget.route;
                          final url = widget.url;
                          final route = '$videoId?url=$url';
                          context.push(route);
                        },
                        child: FadeInRight(child: child),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 5),

              Column(
                children: [
                  //TITULO
                  SizedBox(
                    width: 210,
                    child: Text(
                      widget.nombre,
                      style: titleStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign:
                          TextAlign.left,
                    ),
                  ),

                  const SizedBox(
                      height: 4),

                  SizedBox(
                    width: 210,
                    child: Text(
                      widget.categoria ?? '',
                      style: subtitleStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign:
                          TextAlign.left,
                    ),
                  ),

                  const SizedBox(
                      height: 5),

                  SizedBox(
                    width: 210,
                    child: Text(
                      widget.descripcion ?? '',
                      style: descripcionStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign:
                          TextAlign.left,
                    ),
                  ),
                ],
              )
            ],
          ),
          
          // FIN DE IMAGEN
          
        ],
      ),
    );
  }
}
