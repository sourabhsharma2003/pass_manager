import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/widgets/loading_indicator.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/auth/presentation/views/create_forgot_pin_pass_view.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/state.dart';
import 'package:password_manager/src/features/auth/presentation/views/bio_auth_view.dart';
import 'package:password_manager/src/features/auth/presentation/views/use_password_view.dart';
import 'package:password_manager/src/features/auth/presentation/views/use_pin_view.dart';

class AuthViewSwitcher extends ConsumerWidget {
  const AuthViewSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      authNotifierProvider.select((s) => s.authScreenState),
    );
    return switch (state) {
      AuthScreenState.initial => CreateForgotPinPassView(
        key: WidgetKeys.createPasspinView,
      ),
      AuthScreenState.password => UserPassView(key: WidgetKeys.usePasswordView),
      AuthScreenState.pin => UsePinView(key: WidgetKeys.usePinView),
      AuthScreenState.bioauth => BioAuthView(key: WidgetKeys.bioAuthView),

      AuthScreenState.loading => LoadingIndicator(key: WidgetKeys.loading),
      AuthScreenState.forgot => CreateForgotPinPassView(
        key: WidgetKeys.createPasspinView,
      ),
    };
  }
}
