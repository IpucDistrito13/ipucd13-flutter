import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/congregacion.dart';
import '../presentations.dart';

typedef SearchCongregacionesCallback = Future<List<Congregacion>> Function(
    String query);

class SearchCongregacionDelegate extends SearchDelegate<Congregacion?> {
  final SearchCongregacionesCallback searchCongregaciones;
  List<Congregacion> initialCongregaciones;

  SearchCongregacionDelegate(
      {required this.searchCongregaciones,
      required this.initialCongregaciones});

  //Listener que esta escuchando
  StreamController<List<Congregacion>> debounceCongregaciones =
      StreamController.broadcast();

  StreamController<bool> isLoadingStream = StreamController.broadcast();

  //Periodo de tiempo
  Timer? _debounceTimer;

  //Funcion encargada para emitir los nuesvos resultados de las congregaciones
  void _onQueryChanged(String query) {
    //Cuando escribe, comienza a girar la animacion de cargando
    isLoadingStream.add(true);
    //
    print('Query stream cambio');

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      //if (query.isEmpty) {
      //  debounceCongregaciones.add([]);
      //  return;
      //}

      final congregaciones = await searchCongregaciones(query);
      initialCongregaciones = congregaciones;
      debounceCongregaciones.add(congregaciones);

      //se detiene la animacion tam prondo tenga datos
      isLoadingStream.add(false);

      //Cuando deja de escribir, muestra
      print('Buscando congregación');
    });
  }

  void clearStreams() {
    debounceCongregaciones.close();
  }

  @override
  String get searchFieldLabel => 'Buscar congregación';

  Widget _buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialCongregaciones, //La data tenga el valor anterior
      stream: debounceCongregaciones.stream,
      builder: (context, snapshot) {
        //prnt('Realizando peticion)
        final congregaciones = snapshot.data ?? [];

        return ListView.builder(
          itemCount: congregaciones.length,
          itemBuilder: (context, index) =>
              CustomSliderCongregaciones(congregacion: congregaciones[index]),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    //Construir  acciones
    //print('query: $query');
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(milliseconds: 1000),
              spins: 1,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)),
          );
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //Construir icono

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
    // TODO: implement buildResults
    //Resultado cuando el usuario presione enter

    return _buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    //Cada vez que se oprima teclas se emite el OnQueryChange
    _onQueryChanged(query);

    //Cuando el usuario esta escribiendo, que es lo que se va hacer
    // return const Text('buildSuggestions');
    return _buildResultsAndSuggestions();
  }
}
