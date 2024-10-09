import '../../../../../config/config.dart';
import '../../../auth/domain/entities/usuario.dart';
import '../infrastructures.dart';

class UsuariosMapper {
  static Usuario usuariosToEntity(UsuarioServer usuario) => Usuario(
        codigo: '',
        uuid: usuario.uuid,
        documento: '',
        email: usuario.email ?? '',
        nombre: usuario.nombre,
        apellidos: usuario.apellidos,
        celular: usuario.celular ?? '',
        visibleCelular: usuario.visibleCelular,
        congregacion: usuario.congregacion,
        municipio: usuario.municipio,
        departamento: usuario.departamento,
        imagen: (usuario.imagen != null && usuario.imagen!.isNotEmpty)
            ? '${Environment.apiStorage}/${usuario.imagen}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        //roles: [], // Convertir el campo "role" en una lista
        token: '', direccion: '', // O asigna un valor real si lo tienes
      );

  static Usuario pastoresToEntity(UsuarioServer pastores) => Usuario(
        //type: '',
        codigo: '',
        uuid: pastores.uuid,
        documento: '',
        email: '',
        nombre: pastores.nombre,
        apellidos: pastores.apellidos,
        celular: pastores.celular,
        visibleCelular: pastores.visibleCelular,
        congregacion: pastores.congregacion,
        municipio: pastores.municipio,
        departamento: pastores.departamento,
        imagen: (pastores.imagen != null && pastores.imagen!.isNotEmpty)
            ? '${Environment.apiStorage}/${pastores.imagen}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        token: '',
        direccion: '',
      );

  static Usuario lideresToEntity(UsuarioServer pastores) => Usuario(
        //type: '',
        codigo: '',
        uuid: pastores.uuid,
        documento: '',
        email: '',
        nombre: pastores.nombre,
        apellidos: pastores.apellidos,
        celular: pastores.celular,
        visibleCelular: pastores.visibleCelular,
        congregacion: pastores.congregacion,
        municipio: pastores.municipio,
        departamento: pastores.departamento,
        imagen: (pastores.imagen != null && pastores.imagen!.isNotEmpty)
            ? '${Environment.apiStorage}/${pastores.imagen}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        token: '',
        direccion: '',
      );

  static Usuario usuarioPerfilToEntity(UsuarioDetailsResponse usuario) =>
      Usuario(
        //type: '',
        codigo: '',
        uuid: usuario.data.uuid,
        documento: '',
        email: usuario.data.email,
        nombre: usuario.data.nombre,
        apellidos: usuario.data.apellidos,
        celular: usuario.data.celular,
        visibleCelular: usuario.data.visibleCelular,
        congregacion: usuario.data.congregacion,
        municipio: usuario.data.municipio,
        departamento: usuario.data.departamento,
        imagen: (usuario.data.imagen != '')
            ? '${Environment.apiStorage}/${usuario.data.imagen}'
            : '${Environment.apiStorage}/public/No_imagen/no_image_portada.png',
        token: '',
        direccion: usuario.data.direccion,
      );
}
