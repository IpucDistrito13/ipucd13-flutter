import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

//3.
//CADA VEZ QUE SE CIERRA LA PANTALLA REALIZA EL autoDisponse, PARA LIMPIAR DATOS
final cronogramasProvider =
    StateNotifierProvider<CronogramasNotifier, CronogramasState>((ref) {
  final cronogramasRepository = ref.watch(cronogramasRepositoryProvider);
  return CronogramasNotifier(cronogramasRepository: cronogramasRepository);
});
//3.

//2.
class CronogramasNotifier extends StateNotifier<CronogramasState> {
  final CronogramasRepository cronogramasRepository;

  CronogramasNotifier({required this.cronogramasRepository})
      : super(CronogramasState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    //print('Petición eventos ');
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final cronogramas = await cronogramasRepository.getEvenntosByPage(
        limit: state.limit, offset: state.offset);

    if (cronogramas.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      offset: state.offset + 10,
      cronogramas: [...state.cronogramas, ...cronogramas],
    );
  }
} 
//2.

//1.
class CronogramasState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Cronograma> cronogramas;

  CronogramasState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.isLoading = false,
    this.cronogramas = const [],
  });

  CronogramasState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Cronograma>? cronogramas,
  }) =>
      CronogramasState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        cronogramas: cronogramas ?? this.cronogramas,
      );
}
//1.