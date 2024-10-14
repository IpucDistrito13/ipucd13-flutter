import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/domains.dart';
import '../presentations.dart';
import '../providers/search/search_carpetas_provider.dart';

class CarpetasPrivadoScreen extends ConsumerStatefulWidget {
  static const name = 'carpetas-privado-screen';
  final String slug;
  final String comite;

  const CarpetasPrivadoScreen(
      {super.key, required this.comite, required this.slug});

  @override
  DescargableComiteCarpetasState createState() =>
      DescargableComiteCarpetasState();
}

class DescargableComiteCarpetasState
    extends ConsumerState<CarpetasPrivadoScreen> {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Descargables Privado - ${widget.comite}'),
        actions: [
          IconButton(
            onPressed: () {
              final searchedCarpetas = ref.read(searchedCarpetasProvider);
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
                      //NUMERO DE COLUMNAS
                      crossAxisCount: 3,
                      crossAxisSpacing:
                      //ESPACIO HORIZONTAL ENTRE LOS ITEMS
                          10.0,
                      //ESPACIO VERTICAL ENTRE LOS ITEMS
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: carpetasState.carpetas.length,
                    itemBuilder: (context, index) {
                      final carpeta = carpetasState.carpetas![index];
                      return GestureDetector(
                        onTap: () {
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
                  child: Text('No se encontró información del comité.')),
    );
  }
}

class FolderItem extends StatelessWidget {
  final String folderName;

  const FolderItem({super.key, required this.folderName});

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
