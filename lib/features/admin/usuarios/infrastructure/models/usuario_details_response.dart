// To parse this JSON data, do
//
//     final usuarioDetailsResponse = usuarioDetailsResponseFromJson(jsonString);

import 'dart:convert';

UsuarioDetailsResponse usuarioDetailsResponseFromJson(String str) =>
    UsuarioDetailsResponse.fromJson(json.decode(str));

String usuarioDetailsResponseToJson(UsuarioDetailsResponse data) =>
    json.encode(data.toJson());

class UsuarioDetailsResponse {
  final Data data;

  UsuarioDetailsResponse({
    required this.data,
  });

  factory UsuarioDetailsResponse.fromJson(Map<String, dynamic> json) =>
      UsuarioDetailsResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final String uuid;
  final String type;
  final String nombre;
  final String apellidos;
  final String email;
  final String celular;
  final bool visibleCelular;
  final String congregacion;
  final String municipio;
  final String departamento;
  final List<String> roles;
  final String? imagen;
  final String direccion;

  Data({
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
    required this.roles,
    required this.imagen,
    required this.direccion,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uuid: json["uuid"],
        type: json["type"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        email: json["email"],
        celular: json["celular"],
        visibleCelular:
            json["visibleCelular"] == 1, // Convert 1 to true, 0 to false
        congregacion: json["congregacion"],
        municipio: json["municipio"],
        departamento: json["departamento"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        imagen: json["imagen"] ?? '',
        direccion: json["direccion"],
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
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "imagen": imagen,
        "direccion": direccion,
      };
}
