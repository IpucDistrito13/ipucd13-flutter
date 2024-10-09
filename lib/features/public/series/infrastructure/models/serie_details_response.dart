// To parse this JSON data, do
//
//     final serieDetailsResponse = serieDetailsResponseFromJson(jsonString);

import 'dart:convert';

SerieDetailsResponse serieDetailsResponseFromJson(String str) =>
    SerieDetailsResponse.fromJson(json.decode(str));

String serieDetailsResponseToJson(SerieDetailsResponse data) =>
    json.encode(data.toJson());

class SerieDetailsResponse {
  final Data data;

  SerieDetailsResponse({
    required this.data,
  });

  factory SerieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      SerieDetailsResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final int id;
  final String slug;
  final String type;
  final String nombre;
  final String? descripcion;
  final String? contenido;
  final String? imagenportada;
  final String categoria;

  Data({
    required this.id,
    required this.slug,
    required this.type,
    required this.nombre,
    required this.descripcion,
    required this.contenido,
    required this.imagenportada,
    required this.categoria,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        slug: json["slug"],
        type: json["type"],
        nombre: json["nombre"],
        descripcion: json["descripcion"] ?? '',
        contenido: json["contenido"] ?? '',
        imagenportada: json["imagenportada"] ?? '',
        categoria: json["categoria"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "type": type,
        "nombre": nombre,
        "descripcion": descripcion,
        "contenido": contenido,
        "imagenportada": imagenportada,
        "categoria": categoria,
      };
}
