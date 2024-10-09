class ArchivoDescargableServer {
  final String uuid;
  final String tipo;
  final String url;
  final String nombre;
  final String createdAt;

  ArchivoDescargableServer({
    required this.uuid,
    required this.tipo,
    required this.url,
    required this.nombre,
    required this.createdAt,
  });

  factory ArchivoDescargableServer.fromJson(Map<String, dynamic> json) =>
      ArchivoDescargableServer(
        uuid: json["uuid"],
        tipo: json["tipo"],
        url: json["url"],
        nombre: json["nombre"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "tipo": tipo,
        "url": url,
        "nombre": nombre,
        "created_at": createdAt,
      };
}
