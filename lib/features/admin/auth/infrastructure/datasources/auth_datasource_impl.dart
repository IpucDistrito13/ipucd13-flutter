import 'package:dio/dio.dart';
import '../../../../../config/config.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<UsuarioAuth> checkAuthStatus(String token) async {
    try {
      final response = await dio.get(
        '/check-status',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UsuarioAuth> login(String email, String password) async {
    try {
      final response = await dio.post('/login', data: {
        'email': email,
        'password': password,
        'device_name': 'Flutter',
      });

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      //MUESTRA ERROR SEGUN RESPUESTA DEL SERVIDOR
      if (e.response != null) {
        //print(e.response.toString());
        if (e.response?.statusCode == 401) {
          throw CustomError(
              e.response?.data['message'] ?? 'Credenciales incorrectas.');
        }
      } else {
        //print('Error sin respuesta: ${e.type}');
        throw CustomError('Revisar conexión a internet');
      }

      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<UsuarioAuth> register(String email, String password, String fullName) {
    throw UnimplementedError();
  }
}
