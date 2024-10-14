import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/auth/domain/entities/usuario.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

//3.
//CADA VEZ QUE SE CIERRA LA PANTALLA REALIZA EL autoDisponse, PARA LIMPIAR DATOS
final usuarioMyPerfilProvider = StateNotifierProvider.autoDispose
    .family<UsuarioPerfilNotifier, UsuarioMyPerfilState, String>((ref, uuid) {
  //print('usuarioMyPerfilProvider: $uuid');
  final usuariosRepository = ref.watch(usuariosRepositoryProvider);

  return UsuarioPerfilNotifier(
      usuariosRepository: usuariosRepository, uuid: uuid);
});
//3.

//2.
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
      final usuario = await usuariosRepository.getMyPerfil();
      state = state.copyWith(
        isLoading: false,
        usuario: usuario,
      );
    } catch (e, stackTrace) {
      //print('Error cargando usuario: $e');

    }
  }
}
//2

//1.
class UsuarioMyPerfilState {
  final String uuid;
  final Usuario? usuario;
  final bool isLoading;
  final bool isSaving;
  UsuarioMyPerfilState({
    required this.uuid,
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