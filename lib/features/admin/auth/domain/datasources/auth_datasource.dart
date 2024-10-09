import '../domain.dart';

abstract class AuthDataSource {
  Future<UsuarioAuth> login(String email, String password);
  Future<UsuarioAuth> register(String email, String password, String fullName);
  Future<UsuarioAuth> checkAuthStatus(String token);
}
