import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import 'congregaciones_repository_provider.dart';

final congregacionesProvider =
    StateNotifierProvider<ComitesNotifier, CongregacionesState>((ref) {
  final congregacionesRepository = ref.watch(congregacionesRepositoryProvider);
  return ComitesNotifier(congregacionesRepository: congregacionesRepository);
});
//3.

//2
class ComitesNotifier extends StateNotifier<CongregacionesState> {
  final CongregacionesRepository congregacionesRepository;

  ComitesNotifier({required this.congregacionesRepository})
      : super(CongregacionesState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final congregaciones = await congregacionesRepository.getCongregacioByPage(
        limit: state.limit, offset: state.offset);

    if (congregaciones.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        congregaciones: [...state.congregaciones, ...congregaciones]);

    //print('Nuevas congregaciones');
  }
} //2.

//1.
class CongregacionesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Congregacion> congregaciones;

  CongregacionesState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.congregaciones = const []});

  CongregacionesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Congregacion>? congregaciones,
  }) =>
      CongregacionesState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        congregaciones: congregaciones ?? this.congregaciones,
      );
}
//1.