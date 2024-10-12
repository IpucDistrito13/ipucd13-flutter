import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

//3
final podcastProvider = StateNotifierProvider.autoDispose
    .family<PodcastNotifier, PodcastState, String>((ref, podcastId) {
  final comitesRepository = ref.watch(podcastsRepositoryProvider);

  return PodcastNotifier(
      podcastsRepository: comitesRepository, podcastId: podcastId);
}); //3.

//2
class PodcastNotifier extends StateNotifier<PodcastState> {
  final PodcastsRepository podcastsRepository;

  PodcastNotifier({
    required this.podcastsRepository,
    required String podcastId,
  }) : super(PodcastState(id: podcastId)) {
    loadPodcast();
  }

  Future<void> loadPodcast() async {
    try {
      final podcast = await podcastsRepository.getPodcastById(state.id);

      state = state.copyWith(
        isLoading: false,
        podcast: podcast,
      );
    } catch (e) {
      //print('Error loading podcast: $e');
      //setState(() => ComiteState(isLoading: false));
    }
  }
}

//2.

//1
class PodcastState {
  final String id;
  final Podcast? podcast; //Opcional
  final bool isLoading;
  final bool isSaving;

  PodcastState({
    required this.id,
    this.podcast,
    this.isLoading = true,
    this.isSaving = false,
  });

  PodcastState copyWith({
    String? id,
    Podcast? podcast,
    bool? isLoading,
    bool? isSaving,
  }) =>
      PodcastState(
        id: id ?? this.id,
        podcast: podcast ?? this.podcast,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
//1.