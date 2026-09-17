import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/features/auth/presentation/providers/auth_controllers.dart';
import 'package:password_manager/src/features/auth/presentation/providers/state.dart';

void main() {
  test('test Auth initialstate emition', () {
    final container = ProviderContainer();
    addTearDown(() => container.dispose());
    final initialstate = container.read(authControllerProivder);
    expect(initialstate, equals(const AuthInitial()));
  });
}
