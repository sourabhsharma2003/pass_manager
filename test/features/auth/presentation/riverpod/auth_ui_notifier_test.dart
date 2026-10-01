import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/local/auth_local_notifier.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/local/auth_local_ui_providers.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/local/auth_ui_state.dart';

void main() {
  late AuthLocalNotifier notifier;
  late ProviderContainer container;
  late List<AuthLocalUiState> states;
  setUp(() {
    container = ProviderContainer();
    notifier = container.read(authLocalUiProvider.notifier);
    states = <AuthLocalUiState>[];
  });

  test('Auth Local Notifier Test:if obscure is working or not ', () {
    container.listen(authLocalUiProvider, (prev, next) => states.add(next));

    notifier.createpassobscure();

    expect(states[0].createpassobscure, true);
    notifier.createpassobscure();
    expect(states[1].createpassobscure, false);
    notifier.createpinObscure();

    expect(states[2].createpinobscure, true);
    notifier.createpinObscure();
    expect(states[3].createpinobscure, false);
    notifier.loginpassObscure();
    expect(states[4].loginpassobscure, true);
    notifier.loginpassObscure();
    expect(states[5].createpinobscure, false);
  });
}
