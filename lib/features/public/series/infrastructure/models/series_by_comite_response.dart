// To parse this JSON data, do
//
//     final seriesByComiteResponse = seriesByComiteResponseFromJson(jsonString);

import 'dart:convert';

SeriesByComiteResponse seriesByComiteResponseFromJson(String str) =>
    SeriesByComiteResponse.fromJson(json.decode(str));

String seriesByComiteResponseToJson(SeriesByComiteResponse data) =>
    json.encode(data.toJson());

class SeriesByComiteResponse {
  final List<SeriesByComiteServer> data;

  SeriesByComiteResponse({
    required this.data,
  });

  factory SeriesByComiteResponse.fromJson(Map<String, dynamic> json) =>
      SeriesByComiteResponse(
        data: List<SeriesByComiteServer>.from(
            json["data"].map((x) => SeriesByComiteServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SeriesByComiteServer {
  final int id;
  final String slug;
  final String nombre;
  final String descripcion;
  final String? imagenportada;
  final String categoria;

  SeriesByComiteServer({
    required this.id,
    required this.slug,
    required this.nombre,
    required this.descripcion,
    required this.imagenportada,
    required this.categoria,
  });

  factory SeriesByComiteServer.fromJson(Map<String, dynamic> json) =>
      SeriesByComiteServer(
        id: json["id"],
        slug: json["slug"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        imagenportada: json["imagenportada"] ?? '',
        categoria: json["categoria"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "nombre": nombre,
        "descripcion": descripcion,
        "imagenportada": imagenportada,
        "categoria": categoria,
      };
}
