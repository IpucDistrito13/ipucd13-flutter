import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

//3
final seriesByComiteProvider = StateNotifierProvider.family
    .autoDispose<SeriesNotifier, SeriesState, String>((ref, comiteId) {
  final seriesRepository = ref.watch(seriesRepositoryProvider);
  return SeriesNotifier(seriesRepository: seriesRepository, comiteId: comiteId);
});
//3.

//2
class SeriesNotifier extends StateNotifier<SeriesState> {
  final SeriesRepository seriesRepository;

  SeriesNotifier({required this.seriesRepository, required String comiteId})
      : super(SeriesState(comiteId: comiteId));

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final series = await seriesRepository.getSerieByComite(
      comiteId: state.comiteId!,
      limit: state.limit,
      offset: state.offset,
    );

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

//1.
class SeriesState {
  final String? comiteId;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Serie> series;

  SeriesState({
    required this.comiteId,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.series = const [],
  });

  SeriesState copyWith({
    String? comiteId,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Serie>? series,
  }) =>
      SeriesState(
        comiteId: comiteId ?? this.comiteId,
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        series: series ?? this.series,
      );
}
//1.

