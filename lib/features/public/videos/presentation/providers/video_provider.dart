import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

//3
//Cada vez que se cierre la pantalla realiza el autoDisponse con el din de limpiar datos

final videoProvider = StateNotifierProvider.autoDispose
    .family<VideoNotifier, VideoState, String>((ref, videoId) {
  final videosRepository = ref.watch(videosRepositoryProvider);

  return VideoNotifier(videosRepository: videosRepository, videoId: videoId);
});
//3.

//2
class VideoNotifier extends StateNotifier<VideoState> {
  final VideosRepository videosRepository;

  VideoNotifier({
    required this.videosRepository,
    required String videoId,
  }) : super(VideoState(id: videoId)) {
    loadVideo();
  }

  Future<void> loadVideo() async {
    try {
      final video = await videosRepository.getVideoById(state.id);

      state = state.copyWith(
        isLoading: false,
        video: video, //Opcional
      );
    } catch (e) {
      //print('Error loading video: $e');
      //setState(() => VideoState(isLoading: false));
    }
  }
}
//2

//1
class VideoState {
  final String id;
  final Video? video; //Opcional
  final bool isLoading;
  final bool isSaving;
  VideoState({
    required this.id, //Nunca a a ser null
    this.video,
    this.isLoading = true,
    this.isSaving = false,
  });

  VideoState copyWith({
    String? id,
    Video? video,
    bool? isLoading,
    bool? isSaving,
  }) =>
      VideoState(
        id: id ?? this.id,
        video: video ?? this.video,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
//1.