import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/solicitudes/archivos_descargable/domain/entities/archivo_descargable.dart';
import '/features/admin/solicitudes/archivos_descargable/domain/repositories/archivos_descargable_repository.dart';
import '/features/admin/solicitudes/archivos_descargable/presentation/providers/archivos_descargable_repository_provider.dart';

final archivosDescargableProvider = StateNotifierProvider<
    ArchivosDescargableNotifier, ArchivosDescargableState>((ref) {
  final archivosDescargableRepository =
      ref.watch(archivosDescargableRepositoryProvider);
  return ArchivosDescargableNotifier(
      archivosDescargableRepository: archivosDescargableRepository);
});
//3.

//2
class ArchivosDescargableNotifier
    extends StateNotifier<ArchivosDescargableState> {
  final ArchivosDescargableRepository archivosDescargableRepository;

  ArchivosDescargableNotifier({required this.archivosDescargableRepository})
      : super(ArchivosDescargableState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final archivos = await archivosDescargableRepository.getSArchivosByPage(
        limit: state.limit, offset: state.offset);

    if (archivos.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        archivos: [...state.archivos, ...archivos]);

    //print('Nuevas congregaciones');
  }
} //2.

//1.
class ArchivosDescargableState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<ArchivoDescargable> archivos;

  ArchivosDescargableState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.archivos = const []});

  ArchivosDescargableState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<ArchivoDescargable>? archivos,
  }) =>
      ArchivosDescargableState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        archivos: archivos ?? this.archivos,
      );
}
//1.