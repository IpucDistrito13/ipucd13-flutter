//Usuarios tipo: Pastores / Lideres
class Usuario {
  final String? codigo;
  final String uuid;
  final String documento;
  final String nombre;
  final String apellidos;
  final String celular;
  final bool visibleCelular;
  final String email;
  final String? estado;
  final String congregacion;
  final String municipio;
  final String departamento;
  final String imagen;
  final String direccion;

  final String token;

  Usuario({
    required this.codigo,
    required this.uuid,
    required this.documento,
    required this.email,
    required this.nombre,
    required this.apellidos,
    required this.celular,
    required this.visibleCelular,
    this.estado,
    required this.congregacion,
    required this.municipio,
    required this.departamento,
    required this.imagen,
    required this.direccion,
    required this.token,
  });
}
