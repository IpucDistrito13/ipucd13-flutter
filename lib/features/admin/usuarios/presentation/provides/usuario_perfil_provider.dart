import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/domain/entities/usuario.dart';

import '../../domain/domains.dart';
import '../presentations.dart';
//Cada vez que se cierre la pantalla realiza el autoDisponse con el din de limpiar datos

final usuarioPerfilProvider = StateNotifierProvider.autoDispose
    .family<UsuarioNotifier, UsuarioState, String>((ref, uuid) {
  print('usuarioPerfilProvider: $uuid');
  final usuariosRepository = ref.watch(usuariosRepositoryProvider);

  return UsuarioNotifier(usuariosRepository: usuariosRepository, uuid: uuid);
});
//3.

//2
class UsuarioNotifier extends StateNotifier<UsuarioState> {
  final UsuariosRepository usuariosRepository;

  UsuarioNotifier({
    required this.usuariosRepository,
    required String uuid,
  }) : super(UsuarioState(uuid: uuid)) {
    loadUsuarioPerfil();
  }

  Future<void> loadUsuarioPerfil() async {
    try {
      print('Cargando usuario con UUID: ${state.uuid}');
      final usuario = await usuariosRepository.getUsuarioByUuid(state.uuid);

      print('Usuario cargado: $usuario');
      state = state.copyWith(
        isLoading: false,
        usuario: usuario,
      );
    } catch (e, stackTrace) {
      print('Error loading usuario: $e');
      print('Stack trace: $stackTrace');
      // Manejar el error adecuadamente
    }
  }
}
//2

//1
class UsuarioState {
  final String uuid;
  final Usuario? usuario; //Opcional
  final bool isLoading;
  final bool isSaving;
  UsuarioState({
    required this.uuid, //Nunca a a ser null
    this.usuario,
    this.isLoading = true,
    this.isSaving = false,
  });

  UsuarioState copyWith({
    String? uuid,
    Usuario? usuario,
    bool? isLoading,
    bool? isSaving,
  }) =>
      UsuarioState(
        uuid: uuid ?? this.uuid,
        usuario: usuario ?? this.usuario,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
//1.