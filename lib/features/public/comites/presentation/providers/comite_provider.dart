import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';

//3.
//CADA VEZ QUE SE CIERRA LA PANTALLA REALIZA EL autoDisponse, PARA LIMPIAR DATOS
final comiteProvider = StateNotifierProvider.autoDispose
    .family<ComiteNotifier, ComiteState, String>((ref, comiteId) {
  final comitesRepository = ref.watch(comitesRepositoryProvider);

  return ComiteNotifier(
      comitesRepository: comitesRepository, comiteId: comiteId);
});
//3.

//2
class ComiteNotifier extends StateNotifier<ComiteState> {
  final ComitesRepository comitesRepository;

  ComiteNotifier({
    required this.comitesRepository,
    required String comiteId,
  }) : super(ComiteState(id: comiteId)) {
    loadComite();
  }

  Future<void> loadComite() async {
    try {
      final comite = await comitesRepository.getComiteById(state.id);

      state = state.copyWith(
        isLoading: false,
        comite: comite,
      );
    } catch (e) {
      //print('Error loading comite: $e');
      //setState(() => ComiteState(isLoading: false));
    }
  }
}
//2

//1
class ComiteState {
  final String id;
  final Comite? comite; //Opcional
  final bool isLoading;
  final bool isSaving;
  ComiteState({
    required this.id, //Nunca a a ser null
    this.comite,
    this.isLoading = true,
    this.isSaving = false,
  });

  ComiteState copyWith({
    String? id,
    Comite? comite,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ComiteState(
        id: id ?? this.id,
        comite: comite ?? this.comite,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
//1.