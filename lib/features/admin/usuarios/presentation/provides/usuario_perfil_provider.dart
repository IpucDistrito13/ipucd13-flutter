import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/domain/entities/usuario.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

//3.
//CADA VEZ QUE SE CIERRA LA PANTALLA REALIZA EL autoDisponse, PARA LIMPIAR DATOS
final usuarioPerfilProvider = StateNotifierProvider.autoDispose
    .family<UsuarioNotifier, UsuarioState, String>((ref, uuid) {
  final usuariosRepository = ref.watch(usuariosRepositoryProvider);

  return UsuarioNotifier(usuariosRepository: usuariosRepository, uuid: uuid);
});
//3.

//2.
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
      final usuario = await usuariosRepository.getUsuarioByUuid(state.uuid);

      state = state.copyWith(
        isLoading: false,
        usuario: usuario,
      );
    } catch (e, stackTrace) {
      print('Error cargando usuario (loadUsuarioPerfil): $e');
    }
  }
}
//2.

//1.
class UsuarioState {
  final String uuid;
  final Usuario? usuario;
  final bool isLoading;
  final bool isSaving;
  UsuarioState({
    required this.uuid,
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