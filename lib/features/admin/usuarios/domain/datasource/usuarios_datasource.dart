import '../../../auth/domain/entities/usuario.dart';

abstract class UsuariosDatasource {
  //Listar todos los usuarios
  Future<List<Usuario>> getUsuariosByPage({
    int limit = 10,
    int offset = 0,
  });

  //listar todos los pastores
  Future<List<Usuario>> getPastoresByPage({
    int limit = 10,
    int offset = 0,
  });

  //Mostrar usuario rol lider
  Future<List<Usuario>> getLideresByPage({
    int limit = 10,
    int offset = 0,
  });

  //Obtener detalles del usuario segun el uui
  Future<Usuario> getUsuarioByUuid(String uuid);

  //Mostrar informacion de mi pefil
  Future<Usuario> getMyPerfil();

  //Obtener detalles del pastores segun el uui
  Future<Usuario> getPastoresByUuid(String uuid);

  //Obtener detalles del lideres segun el uui
  Future<Usuario> getLideresByUuid(String uuid);

  //Mostrar usuario segun el termino
  Future<List<Usuario>> searchUsuarioByTerm(String term);

  //Mostrar pastor segun el termino
  Future<List<Usuario>> searchPastorByTerm(String term);

  //Mostrar lider segun el termino
  Future<List<Usuario>> searchLiderByTerm(String term);

  //Crear o actualizar lideres
  Future<List<Usuario>> createUpdateUsuario(
    Map<String, dynamic> usuariosLike,
  );
}
