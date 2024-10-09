class Cronograma {
  final int id;
  final String nombre;
  final DateTime start;
  final DateTime end;
  final String lugar;
  final String? descripcion;
  final dynamic url;

  Cronograma({
    required this.id,
    required this.nombre,
    required this.start,
    required this.end,
    required this.lugar,
    required this.descripcion,
    required this.url,
  });
}
