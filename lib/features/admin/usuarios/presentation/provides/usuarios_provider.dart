//3
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/domain/entities/usuario.dart';
import '../../domain/domains.dart';
import '../presentations.dart';

final usuariosProvider =
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

    //print('Cargando nuevos usuarios...');
  }
} //2.

//1.
class UsuariosState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Usuario> usuarios;

  UsuariosState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.usuarios = const []});

  UsuariosState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Usuario>? usuarios,
  }) =>
      UsuariosState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        usuarios: usuarios ?? this.usuarios,
      );
}
//1.

////////// LIDERES //////////
final usuariosLideresProvider =
    StateNotifierProvider<LideresNotifier, UsuariosState>((ref) {
  final usuariosRepository = ref.watch(usuariosRepositoryProvider);
  return LideresNotifier(usuariosRepository: usuariosRepository);
});

//2
class LideresNotifier extends StateNotifier<UsuariosState> {
  final UsuariosRepository usuariosRepository;

  LideresNotifier({required this.usuariosRepository}) : super(UsuariosState()) {
    loadNextLideresPage();
  }

  Future loadNextLideresPage() async {
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

    //print('Cargando nuevos usuarios...');
  }
} //2.