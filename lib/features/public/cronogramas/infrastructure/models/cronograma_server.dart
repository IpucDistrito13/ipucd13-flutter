class CronogramaServer {
  final int id;
  final String nombre;
  final DateTime start;
  final DateTime end;
  final String? lugar;
  final String? descripcion;
  final String? url;

  CronogramaServer({
    required this.id,
    required this.nombre,
    required this.start,
    required this.end,
    required this.lugar,
    required this.descripcion,
    required this.url,
  });

  factory CronogramaServer.fromJson(Map<String, dynamic> json) =>
      CronogramaServer(
        id: json["id"],
        nombre: json["nombre"],
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
        lugar: json["lugar"],
        descripcion: json["descripcion"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "start": start.toIso8601String(),
        "end": end.toIso8601String(),
        "lugar": lugar,
        "descripcion": descripcion,
        "url": url,
      };
}
