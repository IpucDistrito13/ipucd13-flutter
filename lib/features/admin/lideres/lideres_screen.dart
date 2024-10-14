import '/features/admin/auth/domain/entities/usuario.dart';
import '/features/admin/usuarios/presentation/provides/usuarios_lideres_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LideresScreen extends ConsumerStatefulWidget {
  static const String name = 'lideres-screen';

  const LideresScreen({super.key});

  @override
  LideresScreenState createState() => LideresScreenState();
}

class LideresScreenState extends ConsumerState<LideresScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usuariosLideresProvider.notifier).loadNextPage();
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if ((_scrollController.position.pixels + 200) >=
        _scrollController.position.maxScrollExtent) {
      ref.read(usuariosLideresProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuariosLideresState = ref.watch(usuariosLideresProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Líderes'),
      ),
      body: Stack(
        children: [
          UsuariosListView(
            usuarios: usuariosLideresState.usuarios,
            scrollController: _scrollController,
          ),
          if (usuariosLideresState.isLoading)
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
      onTap: () => _showDetailsDialog(context),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(usuario.imagen),
                    fit: BoxFit.cover,
                  ),
                ),
                child: usuario.imagen == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
              const SizedBox(width: 16),
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
            Text('Celular: ${usuario.celular}'),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: const Text('Llamar'),
                onPressed: () {
                  _makePhoneCall(usuario.celular ?? '');
                  Navigator.of(context).pop(); // Cierra el diálogo
                },
              ),
              TextButton(
                child: const Text('WhatsApp'),
                onPressed: () {
                  _openWhatsApp(usuario.celular ?? '');
                  Navigator.of(context).pop(); // Cierra el diálogo
                },
              ),
            ],
          ),
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el diálogo
            },
          ),
        ],
      );
    },
  );
}


void _openWhatsApp(String phoneNumber) async {
  if (phoneNumber.isEmpty) return;
  final Uri whatsappUri = Uri.parse("https://wa.me/+57$phoneNumber");
  await _launchUrl(whatsappUri);
}


  void _makePhoneCall(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await _launchUrl(launchUri);
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
