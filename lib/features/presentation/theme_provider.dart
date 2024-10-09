import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/config.dart';
import '../shared/shared.dart';

// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

// Un simple boolean
final isDarkmodeProvider = StateProvider((ref) => false);

// Un simple int
final selectedColorProvider = StateProvider((ref) => 0);

// Un objeto de tipo AppTheme (custom)
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


/*
// Controller o Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  // STATE = Estado = new AppTheme();
  ThemeNotifier() : super(AppTheme());

  void toggleDarkmode() {
    state = state.copyWith(isDarkmode: !state.isDarkmode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }
}
*/