import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/features/admin/auth/domain/entities/usuario.dart';
import '/features/admin/usuarios/presentation/provides/usuarios_pastores_provider.dart';

class PastoresScreen extends ConsumerStatefulWidget {
  static const String name = 'pastores-screen';

  const PastoresScreen({super.key});

  @override
  PastoresScreenState createState() => PastoresScreenState();
}

class PastoresScreenState extends ConsumerState<PastoresScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usuariosPastoresProvider.notifier).loadNextPage();
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if ((_scrollController.position.pixels + 200) >=
        _scrollController.position.maxScrollExtent) {
      ref.read(usuariosPastoresProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuariosState = ref.watch(usuariosPastoresProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pastores'),
        /*
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final pastorRepository = ref.read(usuariosRepositoryProvider);
              showSearch(
                context: context,
                delegate: SearchPastorDelegate(),
              );
            },
          ),
        ],
        */
      ),
      body: Stack(
        children: [
          UsuariosListView(
            usuarios: usuariosState.usuarios,
            scrollController: _scrollController,
          ),
          if (usuariosState
              .isLoading) // Asegúrate de tener un indicador de carga en tu estado
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class UsuariosListView extends StatelessWidget {
  final List<Usuario> usuarios;
  final ScrollController scrollController;

  const UsuariosListView({
    super.key,
    required this.usuarios,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: usuarios.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final usuario = usuarios[index];
        return Column(
          children: [
            SlideCustom(usuario: usuario),
            if (index < usuarios.length - 1) const Divider(),
          ],
        );
      },
    );
  }
}

class SlideCustom extends StatelessWidget {
  final Usuario usuario;

  const SlideCustom({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //final route = widget.route;
        final route = usuario.uuid;
        context.push('/usuario-perfil/$route');
      },
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centrar la imagen verticalmente
            children: [
              // Imagen del usuario en formato rectangular
              Container(
                width: 70, // Ajusta el ancho según lo que prefieras
                height: 90, // Ajusta la altura según lo que prefieras
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(8), // Opcional: bordes redondeados
                  image: DecorationImage(
                    image: NetworkImage(
                        usuario.imagen), // URL de la imagen del usuario
                    fit: BoxFit.cover,
                  ),
                ),
                child: usuario.imagen == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
              const SizedBox(width: 16), // Espacio entre la imagen y los datos
              // Columna para los datos del usuario
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${usuario.nombre} ${usuario.apellidos}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      usuario.congregacion,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${usuario.departamento}, ${usuario.municipio}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Celular: ${usuario.celular}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(usuario.congregacion),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dirección: ${usuario.nombre}'),
              Text('Departamento: ${usuario.departamento}'),
              Text('Municipio: ${usuario.municipio}'),
            ],
          ),
          actions: [
            /*
            if (congregacion.direccion.isNotEmpty)
              TextButton(
                child: const Row(
                  children: [
                    Icon(Icons.map, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Ver en el mapa'),
                  ],
                ),
                onPressed: () => _openMap(congregacion.googlemaps),
              ),
              */

            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
