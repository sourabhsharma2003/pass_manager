import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/auth/presentation/providers/state.dart';

class AuthController extends Notifier<AuthState> {
  @override
  build() {
    return const AuthInitial();
  }


  
}

final authControllerProivder = NotifierProvider<AuthController, AuthState>(
  () => AuthController(),
);
