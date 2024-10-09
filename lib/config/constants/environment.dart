import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env.local');
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';

  static String apiUrlBackend =
      dotenv.env['API_URL_BACKEND'] ?? 'No está configurado el API_URL_BACKEND';

  static String apiStorage =
      dotenv.env['API_STORAGE'] ?? 'No está configurado el API_STORAGE';

  static String apiKey =
      dotenv.env['API_KEY'] ?? 'No está configurado el API_KEY';
}
