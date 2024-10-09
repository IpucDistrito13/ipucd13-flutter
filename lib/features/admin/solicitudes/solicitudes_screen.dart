import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/features/admin/solicitudes/archivos_descargable/presentation/providers/archivos_descargable_provider.dart';
import '/features/admin/solicitudes/certificados/bautisamo_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/config.dart';

class SolicitudesScreen extends ConsumerStatefulWidget {
  static const name = 'solicitud-descargable-screen';
  const SolicitudesScreen({super.key});

  @override
  SolicitudesScreenState createState() => SolicitudesScreenState();
}

class SolicitudesScreenState extends ConsumerState<SolicitudesScreen> {
  final ScrollController _scrollController = ScrollController();
  final String baseUrl = Environment.apiStorage;

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels + 200) >=
          _scrollController.position.maxScrollExtent) {
        ref.read(archivosDescargableProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final archivosState = ref.watch(archivosDescargableProvider);

    // Cargar archivos inicialmente si la lista está vacía
    if (archivosState.archivos.isEmpty && !archivosState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(archivosDescargableProvider.notifier).loadNextPage();
      });
    }

    return DefaultTabController(
      length: 2, // Dos pestañas: Archivos y Certificado
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solicitudes'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Archivos'),
              Tab(text: 'Certificado Bautismo'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Archivos descargables
            archivosState.isLoading && archivosState.archivos.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : archivosState.archivos.isEmpty
                    ? const Center(
                        child: Text(
                          'No hay archivos disponibles.',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: archivosState.archivos.length +
                            (archivosState.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == archivosState.archivos.length) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final archivo = archivosState.archivos[index];
                          return ListTile(
                            leading: Icon(
                              archivo.tipo == 'archivo'
                                  ? Icons.insert_drive_file
                                  : Icons.link,
                              color: archivo.tipo == 'archivo'
                                  ? Colors.blue
                                  : Colors.green,
                            ),
                            title: Text(archivo.nombre),
                            subtitle: Text(archivo.tipo),
                            onTap: () {
                              if (archivo.tipo == 'archivo') {
                                _downloadFile(archivo.url, archivo.nombre);
                              } else if (archivo.tipo == 'enlace') {
                                _launchURL(archivo.url);
                              }
                            },
                          );
                        },
                      ),

            // Tab 2: Certificado de bautismo
            BautisamoScreen(),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  Future<void> _downloadFile(String url, String fileName) async {
    print('Nombre archivo: $fileName');
    // Implementación de descarga aquí
  }
}
