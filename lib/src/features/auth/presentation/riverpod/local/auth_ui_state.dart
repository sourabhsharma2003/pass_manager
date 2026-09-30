import 'package:flutter/foundation.dart';

@immutable
class AuthLocalUiState {
  final bool createpinobscure;
  final bool createpassobscure;
  final bool loginpassobscure;
  const AuthLocalUiState({
    this.createpinobscure = false,
    this.createpassobscure = false,
    this.loginpassobscure = false,
  });
  AuthLocalUiState copywith({
    bool? createpinobscure,
    bool? createpassobscure,
    bool? loginpassobscure,
  }) {
    return AuthLocalUiState(
      createpinobscure: createpinobscure ?? this.createpinobscure,
      createpassobscure: createpassobscure ?? this.createpassobscure,
      loginpassobscure: loginpassobscure ?? this.loginpassobscure,
    );
  }
}