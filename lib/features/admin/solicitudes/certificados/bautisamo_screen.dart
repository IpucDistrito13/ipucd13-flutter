import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';

final dioProvider = Provider((ref) => Dio());

class CertificadoNotifier extends StateNotifier<AsyncValue<String?>> {
  CertificadoNotifier(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
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
      'certificado_channel',
      'Certificados',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: '@drawable/notificacion',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Certificado descargado',
      'Toca para abrir el archivo',
      platformChannelSpecifics,
      payload: filePath,
    );
  }

  Future<void> generarCertificado(Map<String, dynamic> params) async {
    state = const AsyncValue.loading();

    try {
      final dio = ref.read(dioProvider);
      const baseUrl =
          'https://ipucdistrito13.org/api/v2/certificado/bautismo/download';

      final Uri uri = Uri.parse(baseUrl).replace(queryParameters: params);
      //print('URL completa: $uri');

      final response = await dio.getUri(
        uri,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final bytes = response.data;
        final nombreBautizado = params['nombre'];
        final filePath = await guardarArchivo(nombreBautizado, bytes);

        // Mostrar la notificación
        await showNotification(filePath);

        state = AsyncValue.data(filePath);
      } else {
        throw Exception(
            'Error al generar el certificado: ${response.statusCode}');
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<String> guardarArchivo(String nombreBautizado, List<int> bytes) async {
    try {
      // Obtener el directorio de documentos de la aplicación
      final appDocDir = await getApplicationDocumentsDirectory();
      final file = File('${appDocDir.path}/$nombreBautizado.pdf');

      // Escribir los bytes en el archivo
      await file.writeAsBytes(bytes);

      //print('Archivo guardado en: ${file.path}');
      return file.path;
    } catch (e) {
      //print('Error al guardar el archivo: $e');
      rethrow;
    }
  }
}

final certificadoProvider =
    StateNotifierProvider<CertificadoNotifier, AsyncValue<String?>>((ref) {
  return CertificadoNotifier(ref);
});

class BautisamoScreen extends ConsumerStatefulWidget {
  const BautisamoScreen({Key? key}) : super(key: key);

  @override
  _BautisamoScreenState createState() => _BautisamoScreenState();
}

class _BautisamoScreenState extends ConsumerState<BautisamoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _fechaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(certificadoProvider.notifier).initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final certificadoState = ref.watch(certificadoProvider);

    ref.listen<AsyncValue<String?>>(certificadoProvider, (_, state) {
      state.whenOrNull(
        data: (filePath) {
          if (filePath != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Certificado generado exitosamente. Revisa la notificación para obtener detalles.'),
              ),
            );
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $error'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nombreController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre del Bautizado',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value!.isEmpty
                              ? 'Por favor ingrese el nombre'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _ubicacionController,
                          decoration: const InputDecoration(
                            labelText: 'Ubicación del Bautismo',
                            prefixIcon: Icon(Icons.location_on),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) => value!.isEmpty
                              ? 'Por favor ingrese la ubicación'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _fechaController,
                          decoration: const InputDecoration(
                            labelText: 'Fecha del Bautismo',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          validator: (value) => value!.isEmpty
                              ? 'Por favor seleccione la fecha'
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: certificadoState.isLoading
                      ? null
                      : () => _generarCertificado(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      certificadoState.isLoading
                          ? 'Generando...'
                          : 'Generar Certificado',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime lastDate = now.add(const Duration(days: 7));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2024),
      lastDate: lastDate,
      selectableDayPredicate: (DateTime date) {
        return date.isBefore(lastDate.add(const Duration(days: 1)));
      },
    );

    if (picked != null) {
      _fechaController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _generarCertificado() {
    if (_formKey.currentState!.validate()) {
      final params = {
        'nombre': _nombreController.text,
        'lugar': _ubicacionController.text,
        'fecha': _fechaController.text,
      };

      ref.read(certificadoProvider.notifier).generarCertificado(params);
    }
  }
}
