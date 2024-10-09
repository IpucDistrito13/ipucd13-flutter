class UsuarioAuth {
  final int id;
  //final String uuid;
  final String nombre;
  final String apellidos;
  final String email;
  final List<String> roles;
  final String token;

  UsuarioAuth({
    required this.id,
    //required this.uuid,
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.roles,
    required this.token,
  });

  bool get isAdmin {
    return roles.contains('Administrador');
  }

  bool get isSuper {
    return roles.contains('Pastor');
  }

  bool get isUser {
    return roles.contains('Developer');
  }

/*
  bool get isAdmin {
    return roles.contains('admin');
  }

  bool get isSuper {
    return roles.contains('super');
  }

  bool get isUser {
    return roles.contains('user');
  }
   */
}
