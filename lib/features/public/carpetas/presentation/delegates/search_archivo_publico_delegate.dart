import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SearchArchivoPublicoDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: () => query = '',
          icon: const Icon(
            Icons.clear,
          ),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //CONSTRUIR ICONOS
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //RESULTADO CUANDO EL USUARIO PRECIONA ENTER
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //CADA VEZ QUE SE OPRIMA TECLAS SE EMITE EL OnQueryChange
    return const Text('buildSuggestions');
  }
}
