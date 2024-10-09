// To parse this JSON data, do
//
//     final episodioByPodcastResponse = episodioByPodcastResponseFromJson(jsonString);

import 'dart:convert';

EpisodioByPodcastResponse episodioByPodcastResponseFromJson(String str) =>
    EpisodioByPodcastResponse.fromJson(json.decode(str));

String episodioByPodcastResponseToJson(EpisodioByPodcastResponse data) =>
    json.encode(data.toJson());

class EpisodioByPodcastResponse {
  final List<EpisodiosByPodcastServer> data;

  EpisodioByPodcastResponse({
    required this.data,
  });

  factory EpisodioByPodcastResponse.fromJson(Map<String, dynamic> json) =>
      EpisodioByPodcastResponse(
        data: List<EpisodiosByPodcastServer>.from(
            json["data"].map((x) => EpisodiosByPodcastServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EpisodiosByPodcastServer {
  final int id;
  final String slug;
  final String titulo;
  final String descripcion;
  final String? imagenportada;
  final String? url;
  final String categoria;

  EpisodiosByPodcastServer({
    required this.id,
    required this.slug,
    required this.titulo,
    required this.descripcion,
    required this.imagenportada,
    required this.url,
    required this.categoria,
  });

  factory EpisodiosByPodcastServer.fromJson(Map<String, dynamic> json) =>
      EpisodiosByPodcastServer(
        id: json["id"],
        slug: json["slug"],
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        imagenportada: json["imagenportada"] ?? '',
        url: json["url"] ?? '',
        categoria: json["categoria"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "titulo": titulo,
        "descripcion": descripcion,
        "imagenportada": imagenportada,
        "url": url,
        "categoria": categoria,
      };
}
