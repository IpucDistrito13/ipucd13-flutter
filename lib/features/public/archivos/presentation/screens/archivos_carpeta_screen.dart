import '../../../../../config/config.dart';
import '/features/public/archivos/presentation/providers/archivos_by_carpeta_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        if (details.payload != null) {
          await OpenFile.open(details.payload);
        }
      },
    );
  }

  Future<void> showNotification(String filePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'archivo_channel',
      'Archivos',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: '@drawable/notificacion',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Archivo descargado',
      'Toca para abrir el archivo',
      platformChannelSpecifics,
      payload: filePath,
    );
  }

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
    final Uri uri = Uri.parse(url);
    
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  Future<void> _downloadFile(String url, String fileName) async {
    try {
      //DIRECTORIO DE DESCARGA
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';

      //DESCARGA DEL ARCHIVO
      Dio dio = Dio();
      await dio.download(url, filePath);

      //MOSTRAR NOTIFICACION AL USUARIO CUANDO LA DESCARGA TERMINE
      await showNotification(filePath);

      //MOSTRAR MENSAJE DE EXITO
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo descargado: $fileName')),
      );
    } catch (e) {
      //MANEJO DE ERRORES
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al descargar archivo.')),
      );
    }
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
                          _downloadFile(
                              '${Environment.apiStorage}/${archivo.url}',
                              archivo.nombre);
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
