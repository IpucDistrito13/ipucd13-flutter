import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import 'providers.dart';

final slidersProvider =
    StateNotifierProvider<ComitesNotifier, SlidersState>((ref) {
  final slidersRepository = ref.watch(slidersRepositoryProvider);
  return ComitesNotifier(slidersRepository: slidersRepository);
});
//3.

//2
class ComitesNotifier extends StateNotifier<SlidersState> {
  final SlidersRepository slidersRepository;

  ComitesNotifier({required this.slidersRepository}) : super(SlidersState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    print('Petición sliders ');
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final sliders = await slidersRepository.getSliderByPage(
        limit: state.limit, offset: state.offset);

    if (sliders.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      sliders: [...state.sliders, ...sliders],
    );
  }
} //2.

//1.
class SlidersState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<SliderPrincipal> sliders;

  SlidersState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.sliders = const [],
  });

  SlidersState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<SliderPrincipal>? sliders,
  }) =>
      SlidersState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        sliders: sliders ?? this.sliders,
      );
}
//1.