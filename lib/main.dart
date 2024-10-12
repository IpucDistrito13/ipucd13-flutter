import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';
import 'features/presentation/theme_provider.dart';
import 'features/shared/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

/*
flutter run --release --dart-define=ENV=local
flutter run --release --dart-define=ENV=production
flutter run --release --dart-define=ENV=post_production

*/
  // Cargar el archivo de entorno basado en el argumento de ejecución
  const environment = String.fromEnvironment('ENV', defaultValue: 'local');
  await Environment.initEnvironment(environment);

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
    final appTheme = ref.watch(themeNotifierProvider);
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: appTheme.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
