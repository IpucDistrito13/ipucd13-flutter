import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/congregacion.dart';
import '../congregaciones_repository_provider.dart';

// Para mantener el estado
final searchQueryCongregacionProvider = StateProvider<String>((ref) => '');

// Implementación
final searchedCongregacionesProvider =
    StateNotifierProvider<SearchedCongregacionesNotifier, List<Congregacion>>(
        (ref) {
  final congregacionRepository = ref.read(congregacionesRepositoryProvider);
  return SearchedCongregacionesNotifier(
      searchCongregaciones: (query) =>
          congregacionRepository.searchCongregacionByTerm(query),
      ref: ref);
});

// Mantener el estado de las congregaciones
typedef SearchCongregacionesCallback = Future<List<Congregacion>> Function(
    String query);

class SearchedCongregacionesNotifier extends StateNotifier<List<Congregacion>> {
  final SearchCongregacionesCallback searchCongregaciones;
  final Ref ref;

  SearchedCongregacionesNotifier({
    required this.searchCongregaciones,
    required this.ref,
  }) : super([]);

  Future<List<Congregacion>> searchCongregacionesByQuery(String query) async {
    final List<Congregacion> congregaciones = await searchCongregaciones(query);
    ref.read(searchQueryCongregacionProvider.notifier).update((state) => query);
    state = congregaciones;
    return congregaciones;
  }
}
