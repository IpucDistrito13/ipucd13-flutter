// To parse this JSON data, do
//
//     final podcastsByComiteResponse = podcastsByComiteResponseFromJson(jsonString);

import 'dart:convert';

PodcastsByComiteResponse podcastsByComiteResponseFromJson(String str) =>
    PodcastsByComiteResponse.fromJson(json.decode(str));

String podcastsByComiteResponseToJson(PodcastsByComiteResponse data) =>
    json.encode(data.toJson());

class PodcastsByComiteResponse {
  final List<PodcastsByComiteServer> data;

  PodcastsByComiteResponse({
    required this.data,
  });

  factory PodcastsByComiteResponse.fromJson(Map<String, dynamic> json) =>
      PodcastsByComiteResponse(
        data: List<PodcastsByComiteServer>.from(
            json["data"].map((x) => PodcastsByComiteServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PodcastsByComiteServer {
  final int id;
  final String slug;
  final String nombre;
  final String descripcion;
  final String? imagenportada;
  final String categoria;

  PodcastsByComiteServer({
    required this.id,
    required this.slug,
    required this.nombre,
    required this.descripcion,
    required this.imagenportada,
    required this.categoria,
  });

  factory PodcastsByComiteServer.fromJson(Map<String, dynamic> json) =>
      PodcastsByComiteServer(
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
        "cantina": categoria,
      };
}
