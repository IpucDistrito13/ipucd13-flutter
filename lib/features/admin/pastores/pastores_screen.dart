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
          if (usuariosState.isLoading)
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
        final route = usuario.uuid;
        context.push('/usuario-perfil/$route');
      },
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment:
                //CENTRAR LA IMAGEN EN VERTICAL
                CrossAxisAlignment.center,
            children: [
              //IMAGEN DEL PASTOR EN FORMATO RESCTANGULAR
              Container(
                //AJUSTA EL ANCHO 
                width: 70,
                //AJUSTA LA ALTURA
                height: 90,
                decoration: BoxDecoration(
                  borderRadius:
                      //BORDES REDONDEADOS
                      BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                        //URL IMAGEN DEL PASTOR
                        usuario.imagen),
                    fit: BoxFit.cover,
                  ),
                ),
                child: usuario.imagen == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
              
              //ESPACIO ENTRE LA IMAGEN Y LOS DATOS
              const SizedBox(width: 17),

              //COLUMNA PARA LOS DATOS DEL USUARIO
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
            BUSCAR PASTOR
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
