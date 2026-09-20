import 'package:flutter/cupertino.dart';

enum AuthScreenState { initial, pin, password, bioauth, authenticated,loading }

@immutable
class Obscure {
  final bool createpinobscure;
  final bool createpassobscure;
  final bool loginpassobscure;
  const Obscure({
    this.createpinobscure = false,
    this.createpassobscure = false,
    this.loginpassobscure = false,
  });
  Obscure copywith({
    bool? createpinobscure,
    bool? createpassobscure,
    bool? loginpassobscure,
  }) {
    return Obscure(
      createpinobscure: createpinobscure ?? this.createpinobscure,
      createpassobscure: createpassobscure ?? this.createpassobscure,
      loginpassobscure: loginpassobscure??this.loginpassobscure
    );
  }
}

@immutable
class AuthState {
  
  final String? error;
  final Obscure obscure;
  final AuthScreenState authScreenState;
  const AuthState({
   
    this.error,
    this.obscure=const Obscure(),
    this.authScreenState = AuthScreenState.initial,
  });

  AuthState copywith({
  
    String? error,
    AuthScreenState? authScreenState,
    Obscure? obscure,
  }) {
    return AuthState(
      
      error: error ?? this.error,
      authScreenState: authScreenState ?? this.authScreenState,
      obscure: obscure ?? this.obscure,
    );
  }
}
