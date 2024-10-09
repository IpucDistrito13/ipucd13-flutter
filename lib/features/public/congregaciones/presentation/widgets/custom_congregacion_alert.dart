import 'package:flutter/material.dart';
import '/features/public/congregaciones/domain/domains.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCongregacionAlert extends StatefulWidget {
  final Congregacion congregacion;
  const CustomCongregacionAlert({super.key, required this.congregacion});

  @override
  CustomCongregacionAlertStatehURL createState() =>
      CustomCongregacionAlertStatehURL();
}

class CustomCongregacionAlertStatehURL extends State<CustomCongregacionAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..forward();
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AlertDialog(
        title: Text(widget.congregacion.congregacion),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen en la parte superior
              Container(
                width: double.infinity, // Toma todo el ancho del AlertDialog
                height: 200, // Ajusta la altura según tus preferencias
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados
                  image: widget.congregacion.fotocongregacion.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(
                              widget.congregacion.fotocongregacion),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: widget.congregacion.fotocongregacion.isEmpty
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
              const SizedBox(height: 16), // Espacio entre la imagen y los datos
              // Datos debajo de la imagen
              Text(
                'Dirección: ${widget.congregacion.direccion}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Departamento: ${widget.congregacion.departamento}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Municipio: ${widget.congregacion.municipio}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (widget.congregacion.urlfacebook.isNotEmpty)
                TextButton(
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.facebook, color: Colors.blue),
                      SizedBox(width: 3),
                      Text('Facebook'),
                    ],
                  ),
                  onPressed: () =>
                      _openFacebook(widget.congregacion.urlfacebook),
                ),
              if (widget.congregacion.googlemaps.isNotEmpty)
                TextButton(
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.map, color: Colors.green),
                      SizedBox(width: 3),
                      Text('Ubicación'),
                    ],
                  ),
                  onPressed: () =>
                      _openGoogleMaps(widget.congregacion.googlemaps),
                ),
            ],
          ),
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _openFacebook(String facebookUrl) async {
    final Uri url = Uri.parse(facebookUrl);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch Facebook';
      }
    } catch (e) {
      print('Error al abrir Facebook: $e');
    }
  }

  Future<void> _openGoogleMaps(String googleMapsUrl) async {
    final Uri url = Uri.parse(googleMapsUrl);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch Google Maps';
      }
    } catch (e) {
      print('Error al abrir Google Maps: $e');
    }
  }
}
