import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/domains.dart';
import '../../presentations.dart';

//1. PARA MANTENE EL ESTADO
final searchQueryCarpetasProvider = StateProvider<String>((ref) => '');

//USAMOS ESTO PARA PASAR EL SLUG
final searchedCarpetasProvider =
    StateNotifierProvider<SearchedCarpetasNotifier, List<Carpeta>>((ref) {
  final carpetaRepository = ref.read(carpetaRepositoryProvider);

  return SearchedCarpetasNotifier(
    searchCarpetas: (query, {comiteSlug}) => carpetaRepository
        .searchCarpetaPrivadoComiteByTerm(query, comiteSlug: comiteSlug),
    ref: ref,
  );
});

//3.

//2. MANTENER EL ESTADO DE LAS CARPETAS
//VOLVEMOS A PASAR EL SLUG DE LA CARPETA
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
    //DEVUELVE LAS CARPETAS ENCONTRADAS
    return carpetas; 
  }
  */

  //INCLUIMOS ESTS PARA QUE PASE EL SLUG
  Future<List<Carpeta>> searchCarpetasByQuery(String query,
      {String? comiteSlug}) async {
    final List<Carpeta> carpetas =
        await searchCarpetas(query, comiteSlug: comiteSlug);
    ref.read(searchQueryCarpetasProvider.notifier).update((state) => query);
    state = carpetas;
    //DEVUELVE LAS CARPETAS ENCONTRADAS
    return carpetas;
  }
}
//2.
