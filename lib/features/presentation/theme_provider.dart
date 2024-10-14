import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/config.dart';
import '../shared/shared.dart';

//LISTADO DE  COLORES INMUTABLE
final colorListProvider = Provider((ref) => colorList);

//ESTABLECEMOS EL MODO
final isDarkmodeProvider = StateProvider((ref) => false);

//ESTABLECEMOS EL COLOR PRINCIPAL
final selectedColorProvider = StateProvider((ref) => 0);

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme()) {
    // Inicializar el estado del tema con las preferencias almacenadas
    final isDarkMode = Preferences.isDarkMode;
    final selectedColorIndex = Preferences.colorMode;

    state = AppTheme(
      selectedColor: selectedColorIndex,
      isDarkmode: isDarkMode,
    );
  }

  void toggleDarkmode() {
    state = state.copyWith(isDarkmode: !state.isDarkmode);
    Preferences.isDarkMode = state.isDarkmode;
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
    Preferences.colorAppMode = colorIndex;
  }
}