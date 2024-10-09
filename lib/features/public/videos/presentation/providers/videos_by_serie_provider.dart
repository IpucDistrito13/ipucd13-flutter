//3
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

final videosByComiteProvider = StateNotifierProvider.family
    .autoDispose<EpisodiosNotifier, VideosState, String>((ref, serieId) {
  final videosRepository = ref.watch(videosRepositoryProvider);
  return EpisodiosNotifier(
      videosRepository: videosRepository, serieId: serieId);
});
//3.

//2
class EpisodiosNotifier extends StateNotifier<VideosState> {
  final VideosRepository videosRepository;

  EpisodiosNotifier({required this.videosRepository, required String serieId})
      : super(VideosState(serieId: serieId));

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final videos = await videosRepository.getVideosBySerie(
      serieId: state.serieId!,
      limit: state.limit,
      offset: state.offset,
    );

    if (videos.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      videos: [...state.videos, ...videos],
    );
  }
}
//2.

//1.
class VideosState {
  final String? serieId;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Video> videos;

  VideosState({
    required this.serieId,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.videos = const [],
  });

  VideosState copyWith({
    String? serieId,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Video>? videos,
  }) =>
      VideosState(
        serieId: serieId ?? this.serieId,
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        videos: videos ?? this.videos,
      );
}
