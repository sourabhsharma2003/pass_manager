import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/entries/presentation/screen/entries_screen.dart';
import 'package:password_manager/src/features/auth/presentation/screens/auth_screen.dart';

class Appshell extends ConsumerStatefulWidget {
  const Appshell({super.key});
  @override
  ConsumerState<Appshell> createState() => _Appshell();


}

class _Appshell extends ConsumerState<Appshell>{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authNotifierProvider.notifier).verify();
    });
  }
  @override
  Widget build(BuildContext context, ) {
    return ref.watch(authNotifierProvider.select((s) => s.authenticated))
        ? EntriesScreen(key: WidgetKeys.entryScreen)
        : AuthScreen(key: WidgetKeys.authScreen);
  }
}
