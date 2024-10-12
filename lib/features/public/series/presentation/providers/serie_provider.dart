//3
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

//3
//Cada vez que se cierre la pantalla realiza el autoDisponse con el din de limpiar datos
final serieProvider = StateNotifierProvider.autoDispose
    .family<SerieNotifier, SerieState, String>((ref, serieId) {
  final comitesRepository = ref.watch(seriesRepositoryProvider);

  return SerieNotifier(serieRepository: comitesRepository, serieId: serieId);
}); //3.

//2
class SerieNotifier extends StateNotifier<SerieState> {
  final SeriesRepository serieRepository;

  SerieNotifier({
    required this.serieRepository,
    required String serieId,
  }) : super(SerieState(id: serieId)) {
    loadserie();
  }

  Future<void> loadserie() async {
    try {
      final serie = await serieRepository.getSerieById(state.id);

      state = state.copyWith(
        isLoading: false,
        serie: serie,
      );
    } catch (e) {
      //print('Error loading serie: $e');
      //setState(() => ComiteState(isLoading: false));
    }
  }
}

//2.

//1
class SerieState {
  final String id;
  final Serie? serie; //Opcional
  final bool isLoading;
  final bool isSaving;

  SerieState({
    required this.id,
    this.serie,
    this.isLoading = true,
    this.isSaving = false,
  });

  SerieState copyWith({
    String? id,
    Serie? serie,
    bool? isLoading,
    bool? isSaving,
  }) =>
      SerieState(
        id: id ?? this.id,
        serie: serie ?? this.serie,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
//1.