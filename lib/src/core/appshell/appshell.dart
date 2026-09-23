import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/entries/presentation/screen/entries_screen.dart';
import 'package:password_manager/src/features/auth/presentation/providers/auth_controllers.dart';
import 'package:password_manager/src/features/auth/presentation/screens/auth_screen.dart';

class Appshell extends ConsumerWidget {
  const Appshell({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authControllerProivder.select((s) => s.authenticated))
        ? EntriesScreen()
        : AuthScreen();
  }
}
