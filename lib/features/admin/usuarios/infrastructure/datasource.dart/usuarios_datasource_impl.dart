import 'package:dio/dio.dart';
import '/features/admin/auth/domain/entities/usuario.dart';
import '/features/admin/usuarios/infrastructure/errors/usuario_errors.dart';

import '../../../../../config/config.dart';
import '../../domain/domains.dart';
import '../infrastructures.dart';

class UsuariosDatasourceImpl extends UsuariosDatasource {
  late final Dio dio;
  final String accessToken;

  UsuariosDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  List<Usuario> _jsonToUsuario(Map<String, dynamic> json) {
    final usuarioServerResponse = UsuarioResponse.fromJson(json);

    final List<Usuario> usuarios = usuarioServerResponse.data
        //Filtrar para que muestre solo los que tienen portada
        //.where((usuarioServer) => usuarioServer. != 'PENDIENTE')
        .map((usuarioServer) => UsuariosMapper.usuariosToEntity(usuarioServer))
        .toList();

    return usuarios;
  }

  @override
  Future<List<Usuario>> createUpdateUsuario(Map<String, dynamic> usuariosLike) {
    // TODO: implement createUpdateUsuario
    throw UnimplementedError();
  }

  @override
  Future<Usuario> getLideresByUuid(String uuid) {
    // TODO: implement getLideresByUuid
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> getPastoresByPage({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final key = Environment.apiKey;
      final url =
          '/v2/usuarios/pastores?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);
      //print(response.data);
      final pastoresServer = UsuarioResponse.fromJson(response.data);
      //print(pastoresServer);
      final List<Usuario> pastores = pastoresServer.data
          .map((pastorServer) => UsuariosMapper.pastoresToEntity(pastorServer))
          .toList();

      return pastores;
    } catch (e) {
      // Manejo de errores
      print('Error fetching usuario: $e');
      return []; // O maneja el error de otra manera, como lanzando una excepción
    }
  }

  @override
  Future<Usuario> getPastoresByUuid(String uuid) {
    // TODO: implement getPastoresByUuid
    throw UnimplementedError();
  }

  @override
  Future<Usuario> getUsuarioByUuid(String uuid) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/usuario/perfil/$uuid';

      final response = await dio.get(url);
      print(response.data);
      final usuarioServer = UsuarioDetailsResponse.fromJson(response.data);
      final Usuario usuario =
          UsuariosMapper.usuarioPerfilToEntity(usuarioServer);
      print(usuario);

      return usuario;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) throw UsuarioNotFound();
      throw Exception();
    } catch (e) {
      // Manejo de errores
      print('Error fetching perfil: $e');
      throw Exception();
    }
  }

  @override
  Future<List<Usuario>> getUsuariosByPage({int limit = 10, int offset = 0}) {
    // TODO: implement getUsuariosByPage
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> getLideresByPage(
      {int limit = 10, int offset = 0}) async {
    try {
      final key = Environment.apiKey;
      final url =
          '/v2/usuarios/lideres?limit=$limit&offset=$offset&api_key=$key';

      final response = await dio.get(url);
      final lideresServer = UsuarioResponse.fromJson(response.data);
      final List<Usuario> lideres = lideresServer.data
          .map((lideresServer) => UsuariosMapper.lideresToEntity(lideresServer))
          .toList();

      return lideres;
    } catch (e) {
      // Manejo de errores
      print('Error fetching lideres: $e');
      return []; // O maneja el error de otra manera, como lanzando una excepción
    }
  }

  @override
  Future<List<Usuario>> searchLiderByTerm(String term) {
    // TODO: implement searchLiderByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> searchPastorByTerm(String term) {
    // TODO: implement searchPastorByTerm
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> searchUsuarioByTerm(String term) {
    // TODO: implement searchUsuarioByTerm
    throw UnimplementedError();
  }

  @override
  Future<Usuario> getMyPerfil() async {
    try {
      final key = Environment.apiKey;
      const url = '/v2/usuario/miPerfil';

      final response = await dio.get(url);
      final usuarioServer = UsuarioDetailsResponse.fromJson(response.data);
      final Usuario usuario =
          UsuariosMapper.usuarioPerfilToEntity(usuarioServer);

      return usuario;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) throw UsuarioNotFound();
      throw Exception();
    } catch (e) {
      // Manejo de errores
      print('Error fetching perfil: $e');
      throw Exception();
    }
  }
}
