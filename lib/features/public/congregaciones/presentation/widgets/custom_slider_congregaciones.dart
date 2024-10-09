import 'package:flutter/material.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

class CustomSliderCongregaciones extends StatelessWidget {
  final Congregacion congregacion;

  const CustomSliderCongregaciones({super.key, required this.congregacion});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showDetailsDialog(context),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80, // Ajusta el ancho según lo que prefieras
                  height: 120, // Ajusta la altura según lo que prefieras
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(8), // Bordes redondeados
                    image: congregacion.fotocongregacion != null
                        ? DecorationImage(
                            image: NetworkImage(congregacion.fotocongregacion),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: congregacion.fotocongregacion == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
                const SizedBox(
                    width: 16), // Espacio entre la imagen y los textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        congregacion.congregacion,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Dirección: ${congregacion.direccion}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Departamento: ${congregacion.departamento}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Municipio: ${congregacion.municipio}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomCongregacionAlert(congregacion: congregacion);
      },
    );
  }
}
