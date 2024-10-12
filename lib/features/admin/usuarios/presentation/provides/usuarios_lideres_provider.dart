//3
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

final usuariosLideresProvider =
    StateNotifierProvider<UsuariosNotifier, UsuariosState>((ref) {
  final usuariosRepository = ref.watch(usuariosRepositoryProvider);
  return UsuariosNotifier(usuariosRepository: usuariosRepository);
});
//3.

//2
class UsuariosNotifier extends StateNotifier<UsuariosState> {
  final UsuariosRepository usuariosRepository;

  UsuariosNotifier({required this.usuariosRepository})
      : super(UsuariosState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final usuarios = await usuariosRepository.getLideresByPage(
        limit: state.limit, offset: state.offset);

    if (usuarios.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        usuarios: [...state.usuarios, ...usuarios]);

    //print('Cargando nuevos lideres...');
  }
} //2.
