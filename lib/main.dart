import 'config/config.dart';
import 'features/presentation/theme_provider.dart';
import 'features/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();

  /*
  flutter run --release --dart-define=ENV=local
  flutter run --release --dart-define=ENV=production
  flutter run --release --dart-define=ENV=post_production
  */

  //CARGAR EL ARCHIVO DE ENTORNOS BASADO EN EL ARGUMENTO DE EJECUCION
  const environment = String.fromEnvironment('ENV', defaultValue: 'production');
  await Environment.initEnvironment(environment);

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
