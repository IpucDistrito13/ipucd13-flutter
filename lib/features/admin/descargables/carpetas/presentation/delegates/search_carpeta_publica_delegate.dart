import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../domain/domains.dart';

typedef SearchCarpetasCallback = Future<List<Carpeta>> Function(String query);

class SearchCarpetaPublicaDelegate extends SearchDelegate<Carpeta?> {
  @override
  String get searchFieldLabel => 'Buscar carpeta';

  final SearchCarpetasCallback searchCarpetas;
  List<Carpeta> initialCaretas;

  StreamController<List<Carpeta>> debouncedCarpetas =
      StreamController.broadcast();

  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;
  SearchCarpetaPublicaDelegate(
      {required this.searchCarpetas, required this.initialCaretas})
      : super(searchFieldLabel: 'Buscar carpeta');

  void _onQueryChanged(String query) {
    //print('Query string cambio');
    isLoadingStream.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      //if (query.isEmpty) {
      //  debounceCongregaciones.add([]);
      //  return;
      //}s

      final carpetas = await searchCarpetas(query);
      debouncedCarpetas.add(carpetas);
      initialCaretas = carpetas;
      //print('Buscando carpeta');
      isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    debouncedCarpetas.close();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(milliseconds: 200),
              spins: 10,
              infinite: true,
              animate: query.isNotEmpty,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              onPressed: () => query = '',
              icon: const Icon(
                Icons.clear,
              ),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialCaretas,
      stream: debouncedCarpetas.stream,
      //future: searchCarpetas(query),
      builder: (context, snapshot) {
        //print('Realizando petición');
        final carpetas = snapshot.data ?? [];

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Número de columnas en la cuadrícula
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75, // Relación de aspecto para los elementos
          ),
          itemCount: carpetas.length,
          itemBuilder: (context, index) => _CarpetaItem(
            carpeta: carpetas[index],
            onCarpetaSelected: (context, carpetas) {
              clearStreams();
              close(context, carpetas);
            },
          ),
        );
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query); // Aplica el debounced
    return _buildResultsAndSuggestions();
  }
}

class _CarpetaItem extends StatelessWidget {
  final Carpeta carpeta;
  final Function onCarpetaSelected;
  const _CarpetaItem({required this.carpeta, required this.onCarpetaSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCarpetaSelected(context, carpeta);
        //
        //close(context, carpeta);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Icono de la carpeta
            const Icon(
              Icons.folder,
              size: 60,
              color:
                  Colors.blue, // Puedes cambiar el color según tu preferencia
            ),
            const SizedBox(height: 8),
            // Nombre de la carpeta
            Text(
              carpeta
                  .nombre, // Asumiendo que 'nombre' es un atributo de 'Carpeta'
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
