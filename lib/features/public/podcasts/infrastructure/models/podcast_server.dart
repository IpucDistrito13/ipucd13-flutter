class PodcastServer {
  final int id;
  final String slug;
  final String nombre;
  final String imagenportada;

  PodcastServer({
    required this.id,
    required this.slug,
    required this.nombre,
    required this.imagenportada,
  });

  factory PodcastServer.fromJson(Map<String, dynamic> json) => PodcastServer(
        id: json["id"],
        slug: json["slug"],
        nombre: json["nombre"],
        imagenportada: json["imagenportada"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "nombre": nombre,
        "imagenportada": imagenportada,
      };
}
