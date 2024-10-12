import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/config.dart';
import '/features/public/screen/transmision_screen.dart';

class BackTransmisionScreen extends ConsumerWidget {
  const BackTransmisionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transmisionAsyncValue = ref.watch(transmisionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transmisión en vivo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Actualiza el estado cuando se presiona el botón
              ref.refresh(transmisionProvider);
            },
          ),
        ],
      ),
      body: Center(
        child: transmisionAsyncValue.when(
          data: (data) {
            final url = data['url'];
            if (url == null) {
              return const Text('No hay transmisión en vivo');
            } else {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cambia el color del botón
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30), // Bordes redondeados
                  ),
                  elevation: 8, // Agrega sombra
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TransmisionScreen()),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.play_arrow,
                        color: Colors.white), // Icono en el botón
                    SizedBox(width: 8),
                    Text(
                      'Ver transmisión ahora',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => const Text(
            'Error: Problemas de conexión.',
          ),
        ),
      ),
    );
  }
}

final transmisionProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final service = TransmisionService();
  final data = await service.fetchTransmision();
  return data;
});

class TransmisionService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchTransmision() async {
    try {
      final response =
          await _dio.get('${Environment.apiUrlBackend}/v1/transmision/envivo');
      return response.data;
    } catch (e) {
      throw Exception('Error fetching transmision');
    }
  }
}
