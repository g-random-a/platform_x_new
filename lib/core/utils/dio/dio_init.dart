import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; 

class DioService {
  late Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? '',
        connectTimeout: const Duration(seconds: 10),  
        receiveTimeout: const Duration(seconds: 10), 
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

  }

  Dio get dio => _dio;

  


  setAuthHeader (String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}