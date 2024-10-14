import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

//3.
//CADA VEZ QUE SE CIERRA LA PANTALLA REALIZA EL autoDisponse, PARA LIMPIAR DATOS
final carpetasPrivadoByComiteProvider = StateNotifierProvider.family
    .autoDispose<CarpetasNotifier, CarpetasState, String>((ref, uuid) {
  final carpetasRepository = ref.watch(carpetaRepositoryProvider);
  return CarpetasNotifier(carpetasRepository: carpetasRepository, uuid: uuid);
});
//3.

//2.
class CarpetasNotifier extends StateNotifier<CarpetasState> {
  final CarpetasRepository carpetasRepository;

  CarpetasNotifier({required this.carpetasRepository, required String uuid})
      : super(CarpetasState(uuid: uuid));

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final carpetas = await carpetasRepository.getCarpetaPrivadoByComite(
      uuid: state.uuid!,
      limit: state.limit,
      offset: state.offset,
    );

    if (carpetas.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      carpetas: [...state.carpetas, ...carpetas],
    );
  }
}
//2.

//1.
class CarpetasState {
  final String? uuid;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Carpeta> carpetas;

  CarpetasState({
    required this.uuid,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.carpetas = const [],
  });

  CarpetasState copyWith({
    String? uuid,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Carpeta>? carpetas,
  }) =>
      CarpetasState(
        uuid: uuid ?? this.uuid,
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        carpetas: carpetas ?? this.carpetas,
      );
}
//1.

