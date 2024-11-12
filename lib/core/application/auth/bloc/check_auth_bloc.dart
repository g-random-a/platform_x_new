import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../event/check_auth_event.dart';
import '../state/check_auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLoginEvent>(_login);
    on<AuthLoadEvent>(_loadAuthStatus);
  }

  Future<void> _loadAuthStatus(AuthEvent event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isAuthenticated = prefs.getString('access_token');
    print("bloc --------------------- bloc");
    print(isAuthenticated);
    emit(isAuthenticated != null ? AuthAuthenticatedState() : AuthUnauthenticatedState());
    // emit(AuthAuthenticatedState());
  }

  Future<void> _login(AuthEvent event, Emitter<AuthState> emit) async {
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('access_token');
    emit(AuthAuthenticatedState());
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    emit(AuthUnauthenticatedState());
  }
}
