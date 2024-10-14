import '/features/admin/auth/domain/entities/usuario.dart';
import '../../domain/domains.dart';

class UsuariosRepositoryImpl extends UsuariosRepository {
  UsuariosDatasource datasource;

  UsuariosRepositoryImpl(this.datasource);

  @override
  Future<List<Usuario>> createUpdateUsuario(Map<String, dynamic> usuariosLike) {
    return datasource.createUpdateUsuario(usuariosLike);
  }

  @override
  Future<Usuario> getLideresByUuid(String uuid) {
    return datasource.getLideresByUuid(uuid);
  }

  @override
  Future<List<Usuario>> getPastoresByPage({int limit = 10, int offset = 0}) {
    return datasource.getPastoresByPage(limit: limit, offset: offset);
  }

  @override
  Future<Usuario> getPastoresByUuid(String uuid) {
    return datasource.getPastoresByUuid(uuid);
  }

  @override
  Future<Usuario> getUsuarioByUuid(String uuid) {
    return datasource.getUsuarioByUuid(uuid);
  }

  @override
  Future<List<Usuario>> getUsuariosByPage({int limit = 10, int offset = 0}) {
    return datasource.getUsuariosByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Usuario>> getLideresByPage({int limit = 10, int offset = 0}) {
    return datasource.getLideresByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Usuario>> searchLiderByTerm(String term) {
    return datasource.searchLiderByTerm(term);
  }

  @override
  Future<List<Usuario>> searchPastorByTerm(String term) {
    return datasource.searchPastorByTerm(term);
  }

  @override
  Future<List<Usuario>> searchUsuarioByTerm(String term) {
    return datasource.searchUsuarioByTerm(term);
  }

  @override
  Future<Usuario> getMyPerfil() {
    return datasource.getMyPerfil();
  }
}
