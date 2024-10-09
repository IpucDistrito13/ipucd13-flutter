class SliderServer {
  final int id;
  final String nombre;
  final String imagen;

  SliderServer({
    required this.id,
    required this.nombre,
    required this.imagen,
  });

  factory SliderServer.fromJson(Map<String, dynamic> json) => SliderServer(
        id: json["id"],
        nombre: json["nombre"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "imagen": imagen,
      };
}
