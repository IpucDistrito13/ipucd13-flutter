import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

final episodiosByComiteProvider = StateNotifierProvider.family
    .autoDispose<EpisodiosNotifier, EpisodiosState, String>((ref, podcastId) {
  final episodiosRepository = ref.watch(episodiosRepositoryProvider);
  return EpisodiosNotifier(
      episodiosRepository: episodiosRepository, podcastId: podcastId);
});
//3.

//2
class EpisodiosNotifier extends StateNotifier<EpisodiosState> {
  final EpisodiosRepository episodiosRepository;

  EpisodiosNotifier(
      {required this.episodiosRepository, required String podcastId})
      : super(EpisodiosState(podcastId: podcastId));

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final episodios = await episodiosRepository.getEpisodiosByPodcast(
      podcastId: state.podcastId!,
      limit: state.limit,
      offset: state.offset,
    );

    if (episodios.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      episodios: [...state.episodios, ...episodios],
    );
  }
}
//2.

//1.
class EpisodiosState {
  final String? podcastId;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Episodio> episodios;

  EpisodiosState({
    required this.podcastId,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.episodios = const [],
  });

  EpisodiosState copyWith({
    String? podcastId,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Episodio>? episodios,
  }) =>
      EpisodiosState(
        podcastId: podcastId ?? this.podcastId,
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        episodios: episodios ?? this.episodios,
      );
}
//1.

