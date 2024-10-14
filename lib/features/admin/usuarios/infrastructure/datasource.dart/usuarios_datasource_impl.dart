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
        //EJEMPLO PARA FILTRAR
        //.where((usuarioServer) => usuarioServer. != 'PENDIENTE')
        .map((usuarioServer) => UsuariosMapper.usuariosToEntity(usuarioServer))
        .toList();

    return usuarios;
  }

  @override
  Future<List<Usuario>> createUpdateUsuario(Map<String, dynamic> usuariosLike) {
    throw UnimplementedError();
  }

  @override
  Future<Usuario> getLideresByUuid(String uuid) {
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
      final pastoresServer = UsuarioResponse.fromJson(response.data);
      final List<Usuario> pastores = pastoresServer.data
          .map((pastorServer) => UsuariosMapper.pastoresToEntity(pastorServer))
          .toList();

      return pastores;
    } catch (e) {
      //MANEJO DE ERRORES
      //print('Error fetching usuario: $e');
      return [];
    }
  }

  @override
  Future<Usuario> getPastoresByUuid(String uuid) {
    throw UnimplementedError();
  }

  @override
  Future<Usuario> getUsuarioByUuid(String uuid) async {
    try {
      final key = Environment.apiKey;
      final url = '/v2/usuario/perfil/$uuid';

      final response = await dio.get(url);
      final usuarioServer = UsuarioDetailsResponse.fromJson(response.data);
      final Usuario usuario =
          UsuariosMapper.usuarioPerfilToEntity(usuarioServer);

      return usuario;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) throw UsuarioNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Usuario>> getUsuariosByPage({int limit = 10, int offset = 0}) {
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
      //MANEJO DE ERRORES
      return [];
    }
  }

  @override
  Future<List<Usuario>> searchLiderByTerm(String term) {
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> searchPastorByTerm(String term) {
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> searchUsuarioByTerm(String term) {
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
      //MANEJO DE ERRORES
      throw Exception();
    }
  }
}
