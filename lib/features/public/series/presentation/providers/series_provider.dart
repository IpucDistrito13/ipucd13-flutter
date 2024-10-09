import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

//3
final seriesProvider =
    StateNotifierProvider<SeriesNotifier, SereiesState>((ref) {
  final seriesRepository = ref.watch(seriesRepositoryProvider);

  return SeriesNotifier(seriesRepository: seriesRepository);
});
//3.

//2
class SeriesNotifier extends StateNotifier<SereiesState> {
  final SeriesRepository seriesRepository;

  SeriesNotifier({required this.seriesRepository}) : super(SereiesState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final series = await seriesRepository.getSeriesByPage(
        limit: state.limit, offset: state.offset);

    if (series.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      series: [...state.series, ...series],
    );
  }
}
//2.

//1
class SereiesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Serie> series;

  SereiesState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.series = const [],
  });

  SereiesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Serie>? series,
  }) =>
      SereiesState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        series: series ?? this.series,
      );
}
//1.