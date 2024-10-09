import '../../domain/domain.dart';

class UserMapper {
  static UsuarioAuth userJsonToEntity(Map<String, dynamic> json) => UsuarioAuth(
        id: json['id'],
        //uuid: json['uuid'],
        nombre: json['nombre'],
        apellidos: json['apellidos'],
        email: json['email'],
        roles: List<String>.from(json['roles'].map((role) => role)),
        token: json['token'] ?? '',
      );
}
