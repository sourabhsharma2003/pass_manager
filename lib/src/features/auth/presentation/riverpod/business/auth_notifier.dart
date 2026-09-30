import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/app_string.dart';

import 'package:password_manager/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/state.dart';

class AuthNotifier extends Notifier<AuthState> {
  late AuthUseCases useCases;
  @override
  build() {
    useCases = ref.read(authUseCasesProvider);
    return AuthState();
  }

  Future<void> verify() async {
    state = state.copywith(
      authenticated: false,
      authScreenState: AuthScreenState.loading,
    );
    final result = await useCases.veriFy();
    if (result.isFailure()) {
      state = AuthState(
        error: result.error,

        authScreenState: AuthScreenState.initial,
      );
      return;
    }
    state = AuthState(authScreenState: AuthScreenState.bioauth);
  }

  Future<void> bioAuth() async {
    state = state.copywith(
      authenticated: false,
      authScreenState: AuthScreenState.loading,
    );
    final result = await useCases.bioAuth.call();
    if (result.isFailure()) {
      state = state.copywith(
      
        authScreenState: AuthScreenState.pin,
      );
      return;
    }
    state = state.copywith(authenticated: true);
  }

  Future<void> createPinAndPass(String pass, String pin) async {
    if (pass.isEmpty || pin.isEmpty) return;
    state = state.copywith(
      authenticated: false,
      authScreenState: AuthScreenState.loading,
    );
    final result = await useCases.createPassPin.call(pass, pin);
    if (result.isFailure()) {
      state = state.copywith(
        error: result.error,

        authScreenState: AuthScreenState.pin,
      );
      return;
    }
    
    state = state.copywith(authenticated: true);
  }

  Future<void> logviaPin(String pin) async {
    if (pin.isEmpty) return;
    state = state.copywith(
      authenticated: false,
      authScreenState: AuthScreenState.loading,
    );
    await Future.delayed(Duration(milliseconds: 500));
    final result = await useCases.checkPin.call(pin);
    if (result.isFailure()) {
      state = state.copywith(
        error: result.error,
        authScreenState: AuthScreenState.pin,
      );
      return;
    }
    state = state.copywith(authenticated: true);
  }

  Future<void> loginviaPassword(String pass) async {
    if (pass.isEmpty) return;
    state = state.copywith(
      authenticated: false,
      authScreenState: AuthScreenState.loading,
      error: null,
    );
    final result = await useCases.checkPass.call(pass);
    if (result.isFailure()) {
      state = state.copywith(
        error: result.error,
        authScreenState: AuthScreenState.password,
      );
      return;
    }
    state = state = state.copywith(authenticated: true);
  }

  Future<void> forgot(String pass, String pin) async {
    if (pass.isEmpty || pin.isEmpty) return;
    state = state.copywith(
      authenticated: false,
      authScreenState: AuthScreenState.loading,
    );
    final result = await useCases.createPassPin.call(pass, pin);
    if (result.isFailure()) {
      state = state.copywith(
        error: result.error,
        authScreenState: AuthScreenState.forgot,
      );
      return;
    }
    state = state.copywith(authenticated: true);
  }

  void usepass() {
    
   
    state = state.copywith(authScreenState: AuthScreenState.password);
  }

  void usepin() {
    state = state = state.copywith(authScreenState: AuthScreenState.pin);
  }

  void goForgot() {
    state = state.copywith(
      forgot: AppString.forgot,
      authScreenState: AuthScreenState.forgot,
    );
  }
}
