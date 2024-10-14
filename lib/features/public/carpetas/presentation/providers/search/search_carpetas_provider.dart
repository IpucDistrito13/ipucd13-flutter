import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/public/carpetas/presentation/providers/carpetas_repository_provider.dart';

import '../../../domain/domains.dart';

//PARA MANTENER EL ESTADO
//1.
final searchQueryCarpetasProvider = StateProvider<String>((ref) => '');
//1.

//PASAMOS AL SLUG
final searchedCarpetasProvider =
    StateNotifierProvider<SearchedCarpetasNotifier, List<Carpeta>>((ref) {
  final carpetaRepository = ref.read(carpetaRepositoryProvider);

  return SearchedCarpetasNotifier(
    searchCarpetas: (query, {comiteSlug}) => carpetaRepository
        .searchCarpetaPublicoComiteByTerm(query, comiteSlug: comiteSlug),
    ref: ref,
  );
});

//3.

//2.
typedef SearchCarpetasCallback = Future<List<Carpeta>> Function(String query,
    {String? comiteSlug});

class SearchedCarpetasNotifier extends StateNotifier<List<Carpeta>> {
  final SearchCarpetasCallback searchCarpetas;
  final Ref ref;

  SearchedCarpetasNotifier({
    required this.searchCarpetas,
    required this.ref,
  }) : super([]);

  /*
  //INCLUIMOS ESTE PARA QUE SE REALICE CONSULTA NORMAL
  Future<List<Carpeta>> searchCarpetasByQuery(String query) async {
    final List<Carpeta> carpetas = await searchCarpetas(query);
    ref.read(searchQueryCarpetasProvider.notifier).update((state) => query);
    state = carpetas;
    return carpetas; // Devuelve las carpetas encontradas
  }
  */

  //INCLUIMOS ESTS PARA QUE PASE EL SLUG
  Future<List<Carpeta>> searchCarpetasByQuery(String query,
      {String? comiteSlug}) async {
    final List<Carpeta> carpetas =
        await searchCarpetas(query, comiteSlug: comiteSlug);
    ref.read(searchQueryCarpetasProvider.notifier).update((state) => query);
    state = carpetas;
    return carpetas;
  }
}
//2.
