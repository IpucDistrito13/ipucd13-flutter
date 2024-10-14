class UsuarioAuth {
  final int id;
  final String nombre;
  final String apellidos;
  final String email;
  final List<String> roles;
  final String token;

  UsuarioAuth({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.roles,
    required this.token,
  });

  bool get isAdmin {
    return roles.contains('Administrador');
  }

  bool get isPastor {
    return roles.contains('Pastor');
  }

    bool get isLider {
    return roles.contains('Lider');
  }

  bool get isDeveloper {
    return roles.contains('Developer');
  }

}
