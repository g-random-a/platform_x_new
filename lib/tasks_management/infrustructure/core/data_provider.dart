import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class DataProvider {
  String? _baseUrl = dotenv.env["API_URL"];
  get baseUrl => _baseUrl;
  set baseUrl(baseurl) {
    _baseUrl = baseUrl;
  }
}