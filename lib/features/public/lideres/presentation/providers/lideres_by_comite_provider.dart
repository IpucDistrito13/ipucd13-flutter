import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

//3. 
//CADA VEZ QUE SE CIERRA LA PANTALLA REALIZA EL autoDisponse, PARA LIMPIAR DATOS
final lideresByComiteProvider = StateNotifierProvider.family
    .autoDispose<LideresNotifier, LideresState, String>((ref, comiteId) {
  final lideresRepository = ref.watch(lideresRepositoryProvider);
  return LideresNotifier(
      lideresRepository: lideresRepository, comiteId: comiteId);
});
//3.

//2
class LideresNotifier extends StateNotifier<LideresState> {
  final LideresRepository lideresRepository;

  LideresNotifier({required this.lideresRepository, required String comiteId})
      : super(LideresState(comiteId: comiteId));

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: false);

    final lideres = await lideresRepository.getLideresByComite(
        comiteId: state.comiteId!, limit: state.limit, offset: state.offset);

    if (lideres.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        lideres: [...state.lideres, ...lideres]);
  }
}

//2.

//1
class LideresState {
  final String? comiteId;
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Lider> lideres;

  LideresState({
    required this.comiteId,
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.lideres = const [],
  });

  LideresState copyWith({
    String? comiteId,
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Lider>? lideres,
  }) =>
      LideresState(
        comiteId: comiteId ?? this.comiteId,
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        lideres: lideres ?? this.lideres,
      );
}
//1.