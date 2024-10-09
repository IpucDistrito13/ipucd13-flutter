import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Admin'),
          const SizedBox(height: 20), // Espacio entre el texto y el botón
          ElevatedButton(
            onPressed: () {
              // Navega a la ruta '/'
              GoRouter.of(context).go('/admin_aux1');
            },
            child: const Text('Admin aux1'),
          ),
        ],
      ),
    );
  }
}
