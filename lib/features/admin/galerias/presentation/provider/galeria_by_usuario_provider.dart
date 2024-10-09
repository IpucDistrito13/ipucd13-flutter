import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/galerias/domain/entities/galeria.dart';
import '/features/admin/galerias/domain/repositories/galerias_repository.dart';
import '/features/admin/galerias/presentation/provider/galerias_repository_provider.dart';

final galeriaByUsuarioProvider = StateNotifierProvider.family
    .autoDispose<GaleriasNotifier, GaleriasState, String>((ref, uuid) {
  final galeriasRepository = ref.watch(galeriasRepositoryProvider);
  return GaleriasNotifier(galeriasRepository: galeriasRepository, uuid: uuid);
});
//3.

//2
class GaleriasNotifier extends StateNotifier<GaleriasState> {
  final GaleriasRepository galeriasRepository;

  GaleriasNotifier({required this.galeriasRepository, required String uuid})
      : super(GaleriasState(uuid: uuid));

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final galerias = await galeriasRepository.getGaleriaPublicaByUsuario(
      uuid: state.uuid!,
      limit: state.limit,
      offset: state.offset,
    );

    if (galerias.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      galerias: [...state.galerias, ...galerias],
    );
  }
}
//2.

//1.
class GaleriasState {
  //final String? podcastId;
  final String? uuid;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Galeria> galerias;

  GaleriasState({
    //required this.podcastId,
    required this.uuid,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.galerias = const [],
  });

  GaleriasState copyWith({
    //String? podcastId,
    String? uuid,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Galeria>? galerias,
  }) =>
      GaleriasState(
        //podcastId: podcastId ?? this.podcastId,
        uuid: uuid ?? this.uuid,
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        galerias: galerias ?? this.galerias,
      );
}
//1.

