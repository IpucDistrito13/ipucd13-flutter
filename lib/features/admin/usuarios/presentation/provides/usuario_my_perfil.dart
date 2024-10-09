import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/domain/entities/usuario.dart';

import '../../domain/domains.dart';
import '../presentations.dart';
//Cada vez que se cierre la pantalla realiza el autoDisponse con el din de limpiar datos

final usuarioMyPerfilProvider = StateNotifierProvider.autoDispose
    .family<UsuarioPerfilNotifier, UsuarioMyPerfilState, String>((ref, uuid) {
  print('usuarioMyPerfilProvider: $uuid');
  final usuariosRepository = ref.watch(usuariosRepositoryProvider);

  return UsuarioPerfilNotifier(
      usuariosRepository: usuariosRepository, uuid: uuid);
});
//3.

//2
class UsuarioPerfilNotifier extends StateNotifier<UsuarioMyPerfilState> {
  final UsuariosRepository usuariosRepository;

  UsuarioPerfilNotifier({
    required this.usuariosRepository,
    required String uuid,
  }) : super(UsuarioMyPerfilState(uuid: uuid)) {
    loadUsuarioPerfil();
  }

  Future<void> loadUsuarioPerfil() async {
    try {
      print('Cargando usuario con UUID: ${state.uuid}');
      final usuario = await usuariosRepository.getMyPerfil();

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
class UsuarioMyPerfilState {
  final String uuid;
  final Usuario? usuario; //Opcional
  final bool isLoading;
  final bool isSaving;
  UsuarioMyPerfilState({
    required this.uuid, //Nunca a a ser null
    this.usuario,
    this.isLoading = true,
    this.isSaving = false,
  });

  UsuarioMyPerfilState copyWith({
    String? uuid,
    Usuario? usuario,
    bool? isLoading,
    bool? isSaving,
  }) =>
      UsuarioMyPerfilState(
        uuid: uuid ?? this.uuid,
        usuario: usuario ?? this.usuario,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
//1.