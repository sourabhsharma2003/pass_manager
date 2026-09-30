import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/local/auth_ui_state.dart';

class AuthLocalNotifier extends Notifier<AuthLocalUiState> {
  @override
  AuthLocalUiState build() {
    return AuthLocalUiState();
  }

  void createpassobscure() {
    state = state.createpassobscure
        ? state.copywith(createpassobscure: false)
        : state.copywith(createpassobscure: true);
  }

  void createpinObscure() {
    state = state.createpinobscure
        ? state.copywith(createpinobscure: false)
        : state.copywith(createpinobscure: true);
  }
  void loginpassObscure(){
    state = state.loginpassobscure
        ? state.copywith(loginpassobscure: false)
        : state.copywith(loginpassobscure: true);
  }
}
