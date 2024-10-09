import '../../domain/domain.dart';
import '../infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({AuthDataSource? dataSource})
      : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<UsuarioAuth> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<UsuarioAuth> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<UsuarioAuth> register(String email, String password, String fullName) {
    return dataSource.register(email, password, fullName);
  }
}
