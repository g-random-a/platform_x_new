abstract class AuthState {
  final bool isAuthenticated;
  AuthState(this.isAuthenticated);
}

class AuthInitialState extends AuthState {
  AuthInitialState() : super(false);
}

class AuthAuthenticatedState extends AuthState {
  AuthAuthenticatedState() : super(true);
}

class AuthUnauthenticatedState extends AuthState {
  AuthUnauthenticatedState() : super(false);
}
