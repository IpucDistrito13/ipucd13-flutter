// To parse this JSON data, do
//
//     final videosBySerieResponse = videosBySerieResponseFromJson(jsonString);

import 'dart:convert';

VideosBySerieResponse videosBySerieResponseFromJson(String str) =>
    VideosBySerieResponse.fromJson(json.decode(str));

String videosBySerieResponseToJson(VideosBySerieResponse data) =>
    json.encode(data.toJson());

class VideosBySerieResponse {
  final List<VideosBySerieServer> data;

  VideosBySerieResponse({
    required this.data,
  });

  factory VideosBySerieResponse.fromJson(Map<String, dynamic> json) =>
      VideosBySerieResponse(
        data: List<VideosBySerieServer>.from(
            json["data"].map((x) => VideosBySerieServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class VideosBySerieServer {
  final int id;
  final String slug;
  final String titulo;
  final String? descripcion;
  final String? imagenportada;
  final String? url;
  final String categoria;
  final String comite;
  final String updatedAt;

  VideosBySerieServer({
    required this.id,
    required this.slug,
    required this.titulo,
    required this.descripcion,
    required this.imagenportada,
    required this.url,
    required this.categoria,
    required this.comite,
    required this.updatedAt,
  });

  factory VideosBySerieServer.fromJson(Map<String, dynamic> json) =>
      VideosBySerieServer(
        id: json["id"],
        slug: json["slug"],
        titulo: json["titulo"],
        descripcion: json["descripcion"] ?? '',
        imagenportada: json["imagenportada"] ?? '',
        url: json["url"] ?? '',
        categoria: json["categoria"],
        comite: json["comite"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "titulo": titulo,
        "descripcion": descripcion,
        "imagenportada": imagenportada,
        "url": url,
        "categoria": categoria,
        "comite": comite,
        "updated_at": updatedAt,
      };
}
