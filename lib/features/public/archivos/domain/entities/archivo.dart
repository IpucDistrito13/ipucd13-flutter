class Archivo {
  final int id;
  final String uuid;
  final String tipo;
  final String url;
  final String nombre;
  final DateTime createdAt;
  final String carpeta;

  Archivo({
    required this.id,
    required this.uuid,
    required this.tipo,
    required this.url,
    required this.nombre,
    required this.createdAt,
    required this.carpeta,
  });
}
