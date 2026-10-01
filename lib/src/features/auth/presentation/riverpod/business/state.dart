import 'package:flutter/cupertino.dart';

enum AuthScreenState { initial, pin, password, bioauth, loading, forgot }



@immutable
class AuthState {
  final String? error;
  
  final String? forgot;
  final bool authenticated;
  final AuthScreenState authScreenState;
  const AuthState({
    this.error,
    this.forgot,
    this.authenticated=false,
   
    this.authScreenState = AuthScreenState.initial,
  });

  AuthState copywith({
    String? error,
    AuthScreenState? authScreenState,
    
    String? forgot,
    bool? authenticated,
  }) {
    return AuthState(
      error: error ?? this.error,
      authScreenState: authScreenState ?? this.authScreenState,
   
      forgot: forgot ?? this.forgot,
      authenticated: authenticated??this.authenticated
    );
  }
}
