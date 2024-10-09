import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuperScreen extends StatelessWidget {
  const SuperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Super aux1'),
          const SizedBox(height: 20), // Espacio entre el texto y el botón
          ElevatedButton(
            onPressed: () {
              // Navega a la ruta '/'
              GoRouter.of(context).go('/super_aux1');
            },
            child: const Text('Super aux 1'),
          ),
        ],
      ),
    );
  }
}
