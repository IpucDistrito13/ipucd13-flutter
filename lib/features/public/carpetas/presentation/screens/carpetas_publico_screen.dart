import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/features/public/carpetas/presentation/delegates/search_carpeta_publica_delegate.dart';

import '../../domain/domains.dart';
import '../presentations.dart';

class CarpetasPublicoScreen extends ConsumerStatefulWidget {
  static const name = 'descargable-public-screen';
  final String slug;
  final String comite;

  const CarpetasPublicoScreen(
      {super.key, required this.comite, required this.slug});

  @override
  DescargableComiteCarpetasState createState() =>
      DescargableComiteCarpetasState();
}

class DescargableComiteCarpetasState
    extends ConsumerState<CarpetasPublicoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(carpetasByComiteProvider(widget.slug).notifier).loadNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final carpetasState = ref.watch(carpetasByComiteProvider(widget.slug));

    print(widget.slug);
    print(widget.comite);

    return Scaffold(
      appBar: AppBar(
        title: Text('Descargables Publico - ${widget.comite}'),
        actions: [
          IconButton(
            onPressed: () {
              final searchedCarpetas = ref.read(
                  searchedCarpetasProvider); //Carpetas previamente buscadas
              final searchQuery = ref.read(searchQueryCarpetasProvider);
              showSearch<Carpeta?>(
                query: searchQuery,
                context: context,
                delegate: SearchCarpetaPublicaDelegate(
                  initialCaretas: searchedCarpetas,
                  searchCarpetas: (query) => ref
                      .read(searchedCarpetasProvider.notifier)
                      .searchCarpetasByQuery(query, comiteSlug: widget.slug),
                ),
              ).then((carpeta) {
                //print(carpeta?.nombre);
                if (carpeta == null) return;

                context.push(
                    '/descargable-publico-archivos/${carpeta.nombre}/${carpeta.slug}');
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: carpetasState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : carpetasState.carpetas != null && carpetasState.carpetas.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Número de columnas
                      crossAxisSpacing:
                          10.0, // Espacio horizontal entre los ítems
                      mainAxisSpacing: 10.0, // Espacio vertical entre los ítems
                    ),
                    itemCount: carpetasState.carpetas.length,
                    itemBuilder: (context, index) {
                      final carpeta = carpetasState.carpetas![index];
                      return GestureDetector(
                        onTap: () {
                          // Navegar a la nueva ruta usando GoRouter
                          context.push(
                            '/descargable-publico-archivos/${carpeta.nombre}/${carpeta.slug}',
                          );
                        },
                        child: FolderItem(
                          folderName: carpeta.nombre,
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: Text('No se encontró información del comité')),
    );
  }
}

class FolderItem extends StatelessWidget {
  final String folderName;

  const FolderItem({required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.folder,
          size: 50.0,
          color: Colors.blue,
        ),
        const SizedBox(height: 8.0),
        Text(
          folderName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
