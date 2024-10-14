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

  //FUNCION ENCARGADA PARA EMITIR LOS NUEVOS RESULTADOS
  void _onQueryChanged(String query) {
    //CUANDO ESCRIBE, COMIENZA A GIRAR LA ANIMACION DE CARGANDO
    isLoadingStream.add(true);
    //print('Query stream cambio');

    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      //if (query.isEmpty) {
      //  debounceCongregaciones.add([]);
      //  return;
      //}s

      final carpetas = await searchCarpetas(query);
      debouncedCarpetas.add(carpetas);
      initialCaretas = carpetas;
      //SE DETIENE LA ANIMACION, CUANDO SE OPTIENE LOS DATOS
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
      builder: (context, snapshot) {
        final carpetas = snapshot.data ?? [];

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //NUMERO DE COLUMNAS EN CUADRICULA
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            //RELACION DE ASPECTO PARA LOS ELEMENTOS
            childAspectRatio: 0.75,
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
    //CONSTRUIR ICONOS
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
    //RESULTADO CUANDO EL USUARIO PRECIONA ENTER
    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //CADA VEZ QUE SE OPRIMA TECLAS SE EMITE EL OnQueryChange
    _onQueryChanged(query);
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
        //close(context, carpeta);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Icon(
              //ICONO DE CARPETA
              Icons.folder,
              size: 60,
              color:
                  Colors.blue,
            ),
            const SizedBox(height: 8),
            //NOMBRE DE LA CARPETA
            Text(
              carpeta
                  .nombre,
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
