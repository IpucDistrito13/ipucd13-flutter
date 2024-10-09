// To parse this JSON data, do
//
//     final archivosByCarpetaResponse = archivosByCarpetaResponseFromJson(jsonString);

import 'dart:convert';

ArchivosByCarpetaResponse archivosByCarpetaResponseFromJson(String str) =>
    ArchivosByCarpetaResponse.fromJson(json.decode(str));

String archivosByCarpetaResponseToJson(ArchivosByCarpetaResponse data) =>
    json.encode(data.toJson());

class ArchivosByCarpetaResponse {
  final List<ArchivosByCarpetaServer> data;

  ArchivosByCarpetaResponse({
    required this.data,
  });

  factory ArchivosByCarpetaResponse.fromJson(Map<String, dynamic> json) =>
      ArchivosByCarpetaResponse(
        data: List<ArchivosByCarpetaServer>.from(
            json["data"].map((x) => ArchivosByCarpetaServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ArchivosByCarpetaServer {
  final int id;
  final String uuid;
  final String tipo;
  final String url;
  final String nombre;
  final DateTime createdAt;
  final String carpeta;

  ArchivosByCarpetaServer({
    required this.id,
    required this.uuid,
    required this.tipo,
    required this.url,
    required this.nombre,
    required this.createdAt,
    required this.carpeta,
  });

  factory ArchivosByCarpetaServer.fromJson(Map<String, dynamic> json) =>
      ArchivosByCarpetaServer(
        id: json["id"],
        uuid: json["uuid"],
        tipo: json["tipo"],
        url: json["url"],
        nombre: json["nombre"],
        createdAt: DateTime.parse(json["created_at"]),
        carpeta: json["carpeta"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "tipo": tipo,
        "url": url,
        "nombre": nombre,
        "created_at": createdAt.toIso8601String(),
        "carpeta": carpeta,
      };
}
