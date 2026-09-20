import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/src/features/auth/data/auth_repo_impl.dart';
import 'package:password_manager/src/features/auth/data/biometric_service.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:password_manager/src/features/auth/presentation/providers/state.dart';

class AuthController extends Notifier<AuthState> {
  final AuthUseCases useCases;
  AuthController(this.useCases);
  @override
  build() {
    return AuthState();
  }

  Future<void> verify() async {
    state = state.copywith(authScreenState: AuthScreenState.loading);
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
    state = state.copywith(authScreenState: AuthScreenState.loading);
    final result = await useCases.bioAuth.call();
    if (result.isFailure()) {
      state = state.copywith(
        error: result.error,
        authScreenState: AuthScreenState.pin,
      );
      return;
    }
    state = state.copywith(authScreenState: AuthScreenState.authenticated);
  }

  Future<void> savePinAndPass(String pass, String pin) async {
    state = state.copywith(authScreenState: AuthScreenState.loading);
    final result = await useCases.savePassPin.call(pass, pin);
    if (result.isFailure()) {
      state = state.copywith(
        error: result.error,

        authScreenState: AuthScreenState.pin,
      );

      return;
    }
    state = state.copywith(authScreenState: AuthScreenState.authenticated);
  }

  Future<void> logviaPin(String pin) async {
    state = state.copywith(authScreenState: AuthScreenState.loading);
    await Future.delayed( Duration(milliseconds: 500));
    final result = await useCases.checkPin.call(pin);
    if (result.isFailure()) {
      state = state.copywith(
        error: result.error,
        authScreenState: AuthScreenState.pin,
      );
      return;
    }
    state = state.copywith(authScreenState: AuthScreenState.authenticated);
  }

  Future<void> loginviaPassword(String pass) async {
    state = state.copywith(authScreenState: AuthScreenState.loading);
    final result = await useCases.checkPass.call(pass);
    if (result.isFailure()) {
      state = state.copywith(
        error: result.error,
        authScreenState: AuthScreenState.password,
      );
      return;
    }
    state = state = state.copywith(
      authScreenState: AuthScreenState.authenticated,
    );
  }

  void usepass() {
    state = state.copywith(authScreenState: AuthScreenState.loading);
     Future.delayed( Duration(milliseconds: 200));
    state = state.copywith(authScreenState: AuthScreenState.password);
  }

  void usepin() {
    state = state = state.copywith(authScreenState: AuthScreenState.pin);
  }

  void obScurepin() {
    state = state.copywith(
      obscure: state.obscure.createpinobscure == false
          ? state.obscure.copywith(createpinobscure: true)
          : state.obscure.copywith(createpinobscure: false),
    );
  }

  void obScureCreatepass() {
    state = state.copywith(
      obscure: state.obscure.createpassobscure == false
          ? state.obscure.copywith(createpassobscure: true)
          : state.obscure.copywith(createpassobscure: false),
    );
  }

  void obScureLoginPass() {
    state = state.copywith(
      obscure: state.obscure.loginpassobscure == false
          ? state.obscure.copywith(loginpassobscure: true)
          : state.obscure.copywith(loginpassobscure: false),
    );
  }
}

final authControllerProivder = NotifierProvider<AuthController, AuthState>(
  () => AuthController(
    AuthUseCases(
      AuthRepoImpl(
        StorageService(FlutterSecureStorage()),
        BiometricService(LocalAuthentication()),
      ),
    ),
  ),
);
