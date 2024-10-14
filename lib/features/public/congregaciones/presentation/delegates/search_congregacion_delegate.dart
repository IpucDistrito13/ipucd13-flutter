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

  //FUNCION ENCARGADA PARA EMITIR LOS NUEVOS RESULTADOS
  void _onQueryChanged(String query) {
    //CUANDO ESCRIBE, COMIENZA A GIRAR LA ANIMACION DE CARGANDO
    isLoadingStream.add(true);
    //print('Query stream cambio');

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      //if (query.isEmpty) {
      //  debounceCongregaciones.add([]);
      //  return;
      //}

      final congregaciones = await searchCongregaciones(query);
      initialCongregaciones = congregaciones;
      debounceCongregaciones.add(congregaciones);

      //SE DETIENE LA ANIMACION, CUANDO SE OPTIENE LOS DATOS
      isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    debounceCongregaciones.close();
  }

  @override
  String get searchFieldLabel => 'Buscar congregación';

  Widget _buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialCongregaciones,
      stream: debounceCongregaciones.stream,
      builder: (context, snapshot) {
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

    //CUANDO EL USUARIO ESTA ESCRIBIENDO
    return _buildResultsAndSuggestions();
  }
}
