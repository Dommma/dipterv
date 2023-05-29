import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get serverURL => dotenv.env['SERVER_URL']!;
}
