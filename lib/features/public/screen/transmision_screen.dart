import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class TransmisionScreen extends ConsumerStatefulWidget {
  const TransmisionScreen({super.key});

  @override
  TransmisionScreenState createState() => TransmisionScreenState();
}

class TransmisionScreenState extends ConsumerState<TransmisionScreen> {
  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    // Forzar orientación horizontal al entrar en la pantalla
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

    // Verificar la API al ingresar a la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transmisionProvider.notifier).fetchTransmision();
    });
  }

  @override
  void dispose() {
    // Restaurar la orientación predeterminada (permitir todas las orientaciones)
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transmisionState = ref.watch(transmisionProvider);

    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;
            return Stack(
              children: [
                transmisionState.when(
                  data: (videoId) {
                    if (videoId != null) {
                      _controller = YoutubePlayerController(
                        initialVideoId: videoId,
                        flags: const YoutubePlayerFlags(
                          autoPlay: true,
                          mute: false,
                          hideControls: true, // Ocultar los controles
                          controlsVisibleAtStart:
                              false, // Controles no visibles al inicio
                          disableDragSeek:
                              true, // Deshabilitar el avance rápido
                        ),
                      );
                      return Column(
                        children: [
                          Expanded(
                            child: YoutubePlayer(
                              controller: _controller!,
                              showVideoProgressIndicator: false,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                          child: Text('No hay transmisión en vivo'));
                    }
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) =>
                      Center(child: Text('Error: $error')),
                ),
                if (!isPortrait)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                if (isPortrait)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: AppBar(
                      title: const Text('Transmisión en vivo'),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

final transmisionProvider =
    StateNotifierProvider<TransmisionNotifier, AsyncValue<String?>>((ref) {
  return TransmisionNotifier();
});

class TransmisionNotifier extends StateNotifier<AsyncValue<String?>> {
  TransmisionNotifier() : super(const AsyncLoading());

  Future<void> fetchTransmision() async {
    state = const AsyncLoading();
    try {
      final dio = Dio();
      final response =
          await dio.get('https://ipucdistrito13.org/api/v2/transmision/envivo');
      final videoId = response.data['url'];

      state = AsyncData(videoId);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
