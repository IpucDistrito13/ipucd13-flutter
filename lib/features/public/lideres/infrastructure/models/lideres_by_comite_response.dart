// To parse this JSON data, do
//
//     final lideresByComiteResponse = lideresByComiteResponseFromJson(jsonString);

import 'dart:convert';

LideresByComiteResponse lideresByComiteResponseFromJson(String str) =>
    LideresByComiteResponse.fromJson(json.decode(str));

String lideresByComiteResponseToJson(LideresByComiteResponse data) =>
    json.encode(data.toJson());

class LideresByComiteResponse {
  final List<LideresByComiteServer> data;

  LideresByComiteResponse({
    required this.data,
  });

  factory LideresByComiteResponse.fromJson(Map<String, dynamic> json) =>
      LideresByComiteResponse(
        data: List<LideresByComiteServer>.from(
            json["data"].map((x) => LideresByComiteServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LideresByComiteServer {
  final int id;
  final String uuid;
  final String nombre;
  final String apellidos;
  final String celular;
  final String imagenperfil;
  final String tipolider;
  //final bool? visiblecelular;

  final String? congregacion;
  final String? municipio;
  final String? departamento;

  LideresByComiteServer({
    required this.id,
    required this.uuid,
    required this.nombre,
    required this.apellidos,
    required this.celular,
    required this.imagenperfil,
    required this.tipolider,
    //required this.visiblecelular,
    this.congregacion,
    this.municipio,
    this.departamento,
  });

  factory LideresByComiteServer.fromJson(Map<String, dynamic> json) =>
      LideresByComiteServer(
        id: json["id"],
        uuid: json["uuid"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        celular: json["celular"],
        imagenperfil: json["imagenperfil"],
        tipolider: json["tipolider"],
        /*visiblecelular: (json["visiblecelular"] is int)
            ? json["visiblecelular"] == 1
            : json["visiblecelular"].toString().toLowerCase() == 'true',
            */
        congregacion: json["congregacion"],
        municipio: json["municipio"],
        departamento: json["departamento"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "nombre": nombre,
        "apellidos": apellidos,
        "celular": celular,
        "imagenperfil": imagenperfil,
        "tipolider": tipolider,
        //"visiblecelular": visiblecelular,
        "congregacion": congregacion,
        "municipio": municipio,
        "departamento": departamento,
      };
}
