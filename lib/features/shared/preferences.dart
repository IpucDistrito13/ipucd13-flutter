import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _pref;
  static const String _isDarkModeKey = "isDarkMode";
  static const bool _defaultIsDarkMode = true;
  static const String _selectedColorKey = "colorAppMode";
  static const int _defaultColorMode = 0;

  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    //LEE EL VALOR DE SharedPreferences O DEVUELVE EL VALOR PREDETERMINADO
    return _pref.getBool(_isDarkModeKey) ?? _defaultIsDarkMode;
  }

  static set isDarkMode(bool value) {
    _pref.setBool(_isDarkModeKey, value);
  }

  static int get colorMode {
    //LEE EL VALOR DE SharedPreferences O DEVUELVE EL VALOR PREDETERMINADO
    return _pref.getInt(_selectedColorKey) ?? _defaultColorMode;
  }

  static set colorAppMode(int value) {
    _pref.setInt(_selectedColorKey, value);
  }
}
