class CongregacionServer {
  final int id;
  final String? uuid;
  final String congregacion;
  final String municipio;
  final String departamento;
  final String? direccion;
  final String? longitud;
  final String? latitud;
  final String? urlfacebook;
  final String? googlemaps;
  final String? fotocongregacion;

  CongregacionServer({
    required this.id,
    required this.uuid,
    required this.congregacion,
    required this.municipio,
    required this.departamento,
    required this.direccion,
    required this.longitud,
    required this.latitud,
    required this.urlfacebook,
    required this.googlemaps,
    required this.fotocongregacion,
  });

  factory CongregacionServer.fromJson(Map<String, dynamic> json) =>
      CongregacionServer(
        id: json["id"],
        uuid: json["uuid"] ?? '',
        congregacion: json["congregacion"],
        municipio: json["municipio"],
        departamento: json["departamento"],
        direccion: json["direccion"] ?? 'Sin dirección',
        longitud: json["longitud"] ?? '',
        latitud: json["latitud"] ?? '',
        urlfacebook: json["urlfacebook"] ?? '',
        googlemaps: json["googlemaps"] ?? '',
        fotocongregacion: json["fotocongregacion"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "congregacion": congregacion,
        "municipio": municipio,
        "departamento": departamento,
        "direccion": direccion,
        "longitud": longitud,
        "latitud": latitud,
        "urlfacebook": urlfacebook,
        "googlemaps": googlemaps,
        "fotocongregacion": fotocongregacion,
      };
}
