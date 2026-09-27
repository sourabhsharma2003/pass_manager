
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/entries/presentation/screen/entries_screen.dart';
import 'package:password_manager/src/features/auth/presentation/screens/auth_screen.dart';

class Appshell extends ConsumerWidget {
  const Appshell({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authNotifierProvider.select((s) => s.authenticated))
        ? EntriesScreen()
        : AuthScreen();
  }
}
