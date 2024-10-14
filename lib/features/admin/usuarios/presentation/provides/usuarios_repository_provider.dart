import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/providers.dart';
import '../../domain/domains.dart';
import '../../infrastructure/infrastructures.dart';

final usuariosRepositoryProvider = Provider<UsuariosRepository>((ref) {
  //PERMITE REALIZAR PETICIONES A APIS PUBLICAS, EXECPTO
  //REQUIERE TOKEN PARA TURAS PROTEGIDAS
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final usuarioRepository =
      UsuariosRepositoryImpl(UsuariosDatasourceImpl(accessToken: accessToken));

  return usuarioRepository;
});
