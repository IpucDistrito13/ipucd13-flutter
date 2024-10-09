import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

//3
final podcastsProvider =
    StateNotifierProvider<PodcatsNotifier, PodcastsState>((ref) {
  final podcatsRepository = ref.watch(podcastsRepositoryProvider);
  return PodcatsNotifier(podcastsRepository: podcatsRepository);
});
//3.

//2
class PodcatsNotifier extends StateNotifier<PodcastsState> {
  final PodcastsRepository podcastsRepository;

  PodcatsNotifier({required this.podcastsRepository}) : super(PodcastsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final podcasts = await podcastsRepository.getPodcastsByPage(
        limit: state.limit, offset: state.offset);

    if (podcasts.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        podcasts: [...state.podcasts, ...podcasts]);
  }
} //2.

//1.
class PodcastsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Podcast> podcasts;

  PodcastsState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.podcasts = const []});

  PodcastsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Podcast>? podcasts,
  }) =>
      PodcastsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        podcasts: podcasts ?? this.podcasts,
      );
}
//1.

