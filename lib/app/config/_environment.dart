import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment{
  AppEnvironment._();

  static String? get apiBaseUrl => dotenv.env['API_BASE_URL'];
  

}
