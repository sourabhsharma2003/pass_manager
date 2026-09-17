sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class Authenticated extends AuthState {
  const Authenticated();
}

class AuthError extends AuthState {
  const AuthError();
}
