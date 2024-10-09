import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '/features/public/archivos/presentation/providers/archivos_by_carpeta_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/config.dart';

class ArchivosCarpetaScreen extends ConsumerStatefulWidget {
  static const String name = 'archivos-screen';
  final String carpeta;
  final String uuid;

  const ArchivosCarpetaScreen({
    super.key,
    required this.carpeta,
    required this.uuid,
  });

  @override
  ArchivosCarpetaScreenState createState() => ArchivosCarpetaScreenState();
}

class ArchivosCarpetaScreenState extends ConsumerState<ArchivosCarpetaScreen> {
  // URL base para los archivos en la nube
  final String baseUrl = Environment.apiStorage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(archivosByCarpetaProvider(widget.uuid).notifier).loadNextPage();
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  Future<void> _downloadFile(String url, String fileName) async {
    print('Descargando: $fileName');
    /*
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final dir = await getExternalStorageDirectory();
      final savePath = '${dir!.path}/$fileName';

      // Concatenar la URL base con la URL relativa del archivo
      final fullUrl = baseUrl + '/' + url;

      try {
        await Dio().download(fullUrl, savePath,
            onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
            // Aquí podrías actualizar un indicador de progreso si lo deseas
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Archivo descargado en $savePath')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al descargar el archivo: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de almacenamiento denegado')),
      );
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    final archivosState = ref.watch(archivosByCarpetaProvider(widget.uuid));

    return Scaffold(
      appBar: AppBar(
        title: Text('Archivos - ${widget.carpeta}'),
      ),
      body: archivosState.isLoading && archivosState.archivos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : archivosState.archivos.isEmpty
              ? const Center(
                  child: Text(
                    'No hay archivos disponibles.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: archivosState.archivos.length,
                  itemBuilder: (context, index) {
                    final archivo = archivosState.archivos[index];
                    return ListTile(
                      leading: Icon(
                        archivo.tipo == 'archivo'
                            ? Icons.insert_drive_file
                            : Icons.link,
                        color: archivo.tipo == 'archivo'
                            ? Colors.blue
                            : Colors.green,
                      ),
                      title: Text(archivo.nombre),
                      subtitle: Text(archivo.tipo),
                      trailing: Text(
                        DateFormat('yyyy-MM-dd').format(archivo.createdAt),
                      ),
                      onTap: () {
                        if (archivo.tipo == 'archivo') {
                          _downloadFile(archivo.url, archivo.nombre);
                        } else if (archivo.tipo == 'enlace') {
                          _launchURL(archivo.url);
                        }
                      },
                    );
                  },
                ),
    );
  }
}
