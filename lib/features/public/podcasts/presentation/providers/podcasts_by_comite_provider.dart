import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

//3
final podcastsByComiteProvider = StateNotifierProvider.family
    .autoDispose<PodcastsNotifier, PodcastsState, String>((ref, comiteId) {
  final podcastsRepository = ref.watch(podcastsRepositoryProvider);
  return PodcastsNotifier(
      podcastsRepository: podcastsRepository, comiteId: comiteId);
});
//3.

//2
class PodcastsNotifier extends StateNotifier<PodcastsState> {
  final PodcastsRepository podcastsRepository;

  PodcastsNotifier({required this.podcastsRepository, required String comiteId})
      : super(PodcastsState(comiteId: comiteId));

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: false);

    final podcasts = await podcastsRepository.getPodcastByComite(
        comiteId: state.comiteId!, limit: state.limit, offset: state.offset);

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
}

//2.

//1
class PodcastsState {
  final String? comiteId;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Podcast> podcasts;

  PodcastsState({
    required this.comiteId,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.podcasts = const [],
  });

  PodcastsState copyWith({
    String? comiteId,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Podcast>? podcasts,
  }) =>
      PodcastsState(
        comiteId: comiteId ?? this.comiteId,
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        podcasts: podcasts ?? this.podcasts,
      );
}
//1.