import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> initEnvironment(String environment) async {
    String envFileName;

    switch (environment) {
      case 'production':
        envFileName = '.env.production';
        break;
      case 'post_production':
        envFileName = '.env.post_production';
        break;
      default:
        envFileName = '.env.local';
    }

    await dotenv.load(fileName: envFileName);
  }

  static String get apiUrl =>
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';

  static String get apiUrlBackend =>
      dotenv.env['API_URL_BACKEND'] ?? 'No está configurado el API_URL_BACKEND';

  static String get apiStorage =>
      dotenv.env['API_STORAGE'] ?? 'No está configurado el API_STORAGE';

  static String get apiKey =>
      dotenv.env['API_KEY'] ?? 'No está configurado el API_KEY';
}
