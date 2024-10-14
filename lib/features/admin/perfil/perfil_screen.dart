import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../usuarios/presentation/provides/usuario_my_perfil.dart';

class PerfilScreen extends ConsumerWidget {
  final String uuid;
  const PerfilScreen({super.key, required this.uuid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perfilState = ref.watch(usuarioMyPerfilProvider(uuid));
    final usuario = perfilState.usuario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: usuario == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  //STACK PARA COLOCAR EL ICONO ENCIMA DE LA IMAGEN
                  Stack(
                    children: [
                      Hero(
                        tag: 'profile-${usuario.uuid}',
                        child: GestureDetector(
                          onTap: () => _showFullImage(context, usuario.imagen),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary, //
                                width: 3, // Grosor del borde
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(usuario.imagen),
                            ),
                          ),
                        ),
                      ),
                      // Ícono con fondo circular en la esquina inferior derecha de la imagen
                      /*
                      PARA SUBIR IMAGEN DE PERFIL
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors
                                    .grey[800] // Fondo oscuro en modo oscuro
                                : Colors.grey[200], // Fondo claro en modo claro
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt, // Ícono de la cámara
                            size: 20,
                            color: Theme.of(context)
                                .colorScheme
                                .primary, // Color del ícono basado en el tema
                          ),
                        ),
                      ),
                      */
                    ],
                  ),

                  const SizedBox(height: 16),
                  Text(
                    '${usuario.nombre} ${usuario.apellidos}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _buildInfoCard(
                          context,
                          'Información Personal',
                          [
                            _buildInfoItem('Código', usuario.uuid),
                            _buildInfoItem('Nombre', usuario.nombre),
                            _buildInfoItem('Apellidos', usuario.apellidos),
                          ],
                          onEdit: () => _showEditDialog(
                              context, 'Información Personal', usuario),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          context,
                          'Contacto',
                          [
                            _buildInfoItem(
                                'Celular',
                                usuario.visibleCelular
                                    ? usuario.celular
                                    : 'No visible'),
                            _buildInfoItem('Email', usuario.email),
                          ],
                          onEdit: () =>
                              _showEditDialog(context, 'Contacto', usuario),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoCard(
                          context,
                          'Ubicación',
                          [
                            _buildInfoItem(
                                'Congregación', usuario.congregacion),
                            _buildInfoItem('Municipio', usuario.municipio),
                            _buildInfoItem(
                                'Departamento', usuario.departamento),
                            _buildInfoItem('Dirección', usuario.direccion),
                          ],
                          onEdit: () =>
                              _showEditDialog(context, 'Ubicación', usuario),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, String title, List<Widget> children,
      {required VoidCallback onEdit}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),

                
                /**
                 * BOTON PARA EDITAR LA INFORMACION
                 * SE COMENTA PARA QUE NO SE MUESTRE EL ICONO DE EDITAR
                 * SE PUEDE IMPLEMENTO EL CUADRO DE DIALOGO CON LOS DATOS DEL USUARIO
                 * PARA SER EDITADOS Y ACTUALIZADOS
                 * FALTA CONFIGURAR EL BACKEND
                 */
                //TODO: CONFIGURAR EL BACKEND PARA ACTUALIZAR LOS DATOS
                // IconButton(
                //   icon: const Icon(Icons.edit),
                //   onPressed: onEdit,
                // ),
                
              ],
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, String title, dynamic usuario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar $title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _buildEditFields(title, usuario),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () {
                //AQUI LA LOGICA PARA GIARDAR LOS CAMBIOS
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildEditFields(String title, dynamic usuario) {
    switch (title) {
      case 'Información Personal':
        return [
          TextField(
            decoration: const InputDecoration(labelText: 'Nombre'),
            controller: TextEditingController(text: usuario.nombre),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Apellidos'),
            controller: TextEditingController(text: usuario.apellidos),
          ),
        ];
      case 'Contacto':
        return [
          TextField(
            decoration: const InputDecoration(labelText: 'Celular'),
            controller: TextEditingController(text: usuario.celular),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Email'),
            controller: TextEditingController(text: usuario.email),
          ),
          SwitchListTile(
            title: const Text('Mostrar celular'),
            value: usuario.visibleCelular,
            onChanged: (bool value) {
              // Aquí iría la lógica para cambiar la visibilidad del celular
            },
          ),
        ];
      case 'Ubicación':
        return [
          TextField(
            decoration: const InputDecoration(labelText: 'Congregación'),
            controller: TextEditingController(text: usuario.congregacion),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Municipio'),
            controller: TextEditingController(text: usuario.municipio),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Departamento'),
            controller: TextEditingController(text: usuario.departamento),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Dirección'),
            controller: TextEditingController(text: usuario.direccion),
          ),
        ];
      default:
        return [];
    }
  }

  void _showFullImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: InteractiveViewer(
              child: Image.network(imageUrl),
            ),
          ),
        );
      },
    );
  }
}
