// To parse this JSON data, do
//
//     final videoDetailsResponse = videoDetailsResponseFromJson(jsonString);

import 'dart:convert';

VideoDetailsResponse videoDetailsResponseFromJson(String str) =>
    VideoDetailsResponse.fromJson(json.decode(str));

String videoDetailsResponseToJson(VideoDetailsResponse data) =>
    json.encode(data.toJson());

class VideoDetailsResponse {
  final Data data;

  VideoDetailsResponse({
    required this.data,
  });

  factory VideoDetailsResponse.fromJson(Map<String, dynamic> json) =>
      VideoDetailsResponse(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  final int id;
  final String type;
  final String nombre;
  final String slug;
  final String? descripcion;
  final String? url;
  final String serie;
  final String comite;
  final String categoria;

  Data({
    required this.id,
    required this.type,
    required this.nombre,
    required this.slug,
    required this.descripcion,
    required this.url,
    required this.serie,
    required this.comite,
    required this.categoria,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        type: json["type"],
        nombre: json["nombre"],
        slug: json["slug"],
        descripcion: json["descripcion"] ?? '',
        url: json["url"] ?? '',
        serie: json["serie"],
        comite: json["comite"],
        categoria: json["categoria"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "nombre": nombre,
        "slug": slug,
        "descripcion": descripcion,
        "url": url,
        "serie": serie,
        "comite": comite,
        "categoria": categoria,
      };
}
