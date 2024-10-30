import 'package:dio/dio.dart';
import '../data%20provider/login_provider.dart';

class LoginRepository {
  final LoginProvider provider;
  LoginRepository(this.provider);

  Future<Response> login(Map<String, dynamic> user) {
    return provider.loging(user);
  }
}
