//Podcast detallado del servidor <Lista>
class PodcastDetailsServer {
  final int id;
  final String type;
  final String nombre;
  final String slug;
  final String descripcion;
  final String? contenido;
  final String? imagenportada;
  final String? categoria;

  PodcastDetailsServer({
    required this.id,
    required this.type,
    required this.nombre,
    required this.slug,
    required this.descripcion,
    required this.contenido,
    required this.imagenportada,
    required this.categoria,
  });

  factory PodcastDetailsServer.fromJson(Map<String, dynamic> json) =>
      PodcastDetailsServer(
        id: json["id"],
        type: json["type"],
        nombre: json["nombre"],
        slug: json["slug"],
        descripcion: json["descripcion"],
        contenido: json["contenido"] ?? '',
        imagenportada: json["imagenportada"] ?? '',
        categoria: json["categoria"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "nombre": nombre,
        "slug": slug,
        "descripcion": descripcion,
        "contenido": contenido,
        "imagenportada": imagenportada,
        "categoria": categoria,
      };
}
