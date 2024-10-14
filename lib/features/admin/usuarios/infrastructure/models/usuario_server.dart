class UsuarioServer {
  final String uuid;
  final String? type;
  final String nombre;
  final String apellidos;
  final String? email;
  final String celular;
  final bool visibleCelular;
  final String congregacion;
  final String municipio;
  final String departamento;
  //final List<String>? roles;
  final String? imagen;

  UsuarioServer({
    required this.uuid,
    required this.type,
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.celular,
    required this.visibleCelular,
    required this.congregacion,
    required this.municipio,
    required this.departamento,
    //required this.roles,
    required this.imagen,
  });

  factory UsuarioServer.fromJson(Map<String, dynamic> json) => UsuarioServer(
        uuid: json["uuid"],
        type: json["type"] ?? '',
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        email: json["email"] ?? '',
        celular: json["celular"],
        //CONVERTIR 1 EN true, 0 EN falso
        visibleCelular: json["visibleCelular"] == 1,
        congregacion: json["congregacion"],
        municipio: json["municipio"],
        departamento: json["departamento"],
        //roles: List<String>.from(json["roles"].map((x) => x)),
        imagen: json["imagen"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "type": type,
        "nombre": nombre,
        "apellidos": apellidos,
        "email": email,
        "celular": celular,
        "visibleCelular": visibleCelular,
        "congregacion": congregacion,
        "municipio": municipio,
        "departamento": departamento,
        //"roles": List<String>.from(roles.map((roles) => roles)),
        "imagen": imagen,
      };
}
