import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

final archivosByCarpetaProvider = StateNotifierProvider.family
    .autoDispose<ArchivosNotifier, ArchivosState, String>((ref, uuid) {
  final archivosRepository = ref.watch(archivoRepositoryProvider);
  return ArchivosNotifier(archivosRepository: archivosRepository, uuid: uuid);
});
//3.

//2
class ArchivosNotifier extends StateNotifier<ArchivosState> {
  final ArchivosRepository archivosRepository;

  ArchivosNotifier({required this.archivosRepository, required String uuid})
      : super(ArchivosState(uuid: uuid));

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final archivos = await archivosRepository.getArchivosByCarpeta(
      uuid: state.uuid!,
      limit: state.limit,
      offset: state.offset,
    );

    if (archivos.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      archivos: [...state.archivos, ...archivos],
    );
  }
}
//2.

//1.
class ArchivosState {
  final String? uuid;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Archivo> archivos;

  ArchivosState({
    required this.uuid,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.archivos = const [],
  });

  ArchivosState copyWith({
    String? uuid,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Archivo>? archivos,
  }) =>
      ArchivosState(
        uuid: uuid ?? this.uuid,
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        archivos: archivos ?? this.archivos,
      );
}
//1.

