import 'package:flutter_dotenv/flutter_dotenv.dart';

class configs {
  static String BASE_URL = dotenv.env['API_BASE_URL'] ?? '';
  static String GOOGLE_MAPS_API_KEY = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
}