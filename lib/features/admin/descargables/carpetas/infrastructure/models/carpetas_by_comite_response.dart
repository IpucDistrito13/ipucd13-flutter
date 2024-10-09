// To parse this JSON data, do
//
//     final carpetasByComiteResponse = carpetasByComiteResponseFromJson(jsonString);

import 'dart:convert';

CarpetasByComiteResponse carpetasByComiteResponseFromJson(String str) =>
    CarpetasByComiteResponse.fromJson(json.decode(str));

String carpetasByComiteResponseToJson(CarpetasByComiteResponse data) =>
    json.encode(data.toJson());

class CarpetasByComiteResponse {
  final List<CarpetasByComiteServer> data;

  CarpetasByComiteResponse({
    required this.data,
  });

  factory CarpetasByComiteResponse.fromJson(Map<String, dynamic> json) =>
      CarpetasByComiteResponse(
        data: List<CarpetasByComiteServer>.from(
            json["data"].map((x) => CarpetasByComiteServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CarpetasByComiteServer {
  final int id;
  final String slug;
  final String nombre;
  final dynamic descripcion;
  final String comite;
  final String? createdAt;

  CarpetasByComiteServer({
    required this.id,
    required this.slug,
    required this.nombre,
    required this.descripcion,
    required this.comite,
    required this.createdAt,
  });

  factory CarpetasByComiteServer.fromJson(Map<String, dynamic> json) =>
      CarpetasByComiteServer(
        id: json["id"],
        slug: json["slug"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        comite: json["comite"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "nombre": nombre,
        "descripcion": descripcion,
        "comite": comite,
        "createdAt": createdAt,
      };
}
