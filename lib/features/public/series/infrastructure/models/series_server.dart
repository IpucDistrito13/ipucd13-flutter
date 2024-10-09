class SerieServer {
  final int id;
  final dynamic nombre;
  final String? imagenportada;
  final String? imagenbanner;

  SerieServer({
    required this.id,
    required this.nombre,
    required this.imagenportada,
    required this.imagenbanner,
  });

  factory SerieServer.fromJson(Map<String, dynamic> json) => SerieServer(
        id: json["id"],
        nombre: json["nombre"],
        imagenportada: json["imagenportada"] ?? '',
        imagenbanner: json["imagenbanner"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagenportada": imagenportada,
        "imagenbanner": imagenbanner,
      };
}
