import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ipucd13_flutter/config/constants/environment.dart';
import 'package:ipucd13_flutter/config/router/app_router.dart';
import 'package:ipucd13_flutter/features/presentation/theme_provider.dart';
import 'package:ipucd13_flutter/features/shared/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init(); // Inicializa las preferencias

  await Environment.initEnvironment(); // Inicializa el entorno, si es necesario

  // Forzar la orientación a vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme =
        ref.watch(themeNotifierProvider); // Obtenemos el tema actual

    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter, // Configuración de rutas
      theme: appTheme.getTheme(), // Aplicamos el tema actual
      debugShowCheckedModeBanner: false,
    );
  }
}
