class ComitesServer {
  final int id;
  final String slug;
  final String nombre;
  final String? descripcion;
  final String? imagenportada;

  ComitesServer({
    required this.id,
    required this.slug,
    required this.nombre,
    required this.descripcion,
    required this.imagenportada,
  });

  factory ComitesServer.fromJson(Map<String, dynamic> json) => ComitesServer(
        id: json["id"],
        slug: json["slug"],
        nombre: json["nombre"],
        descripcion: json["descripcion"] ?? '',
        imagenportada: json["imagenportada"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "imagenportada": imagenportada,
      };
}
