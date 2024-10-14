
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domain.dart';

//3.
//CADA VEZ QUE SE CIERRA LA PANTALLA REALIZA EL autoDisponse, PARA LIMPIAR DATOS
final comitesProvider =
    StateNotifierProvider<ComitesNotifier, ComitesState>((ref) {
  final comitesRepository = ref.watch(comitesRepositoryProvider);
  return ComitesNotifier(comitesRepository: comitesRepository);
});
//3.

//2.
class ComitesNotifier extends StateNotifier<ComitesState> {
  final ComitesRepository comitesRepository;

  ComitesNotifier({required this.comitesRepository}) : super(ComitesState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final comites = await comitesRepository.getComiteByPage(
        limit: state.limit, offset: state.offset);

    if (comites.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        comites: [...state.comites, ...comites]);
  }
} 
//2.

//1.
class ComitesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Comite> comites;

  ComitesState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.comites = const []});

  ComitesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Comite>? comites,
  }) =>
      ComitesState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        comites: comites ?? this.comites,
      );
}
//1.