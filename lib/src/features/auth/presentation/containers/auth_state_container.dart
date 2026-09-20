import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/images.dart';
import 'package:password_manager/src/core/constants/loading_indicator.dart';
import 'package:password_manager/src/features/add_new_password/presentation/screen/entries_screen.dart';
import 'package:password_manager/src/features/auth/presentation/containers/create_pass_pin_state.dart';
import 'package:password_manager/src/features/auth/presentation/containers/use_pass_container.dart';
import 'package:password_manager/src/features/auth/presentation/containers/use_pin_container.dart';
import 'package:password_manager/src/features/auth/presentation/providers/auth_controllers.dart';
import 'package:password_manager/src/features/auth/presentation/providers/state.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/custom_pin_field.dart';

class AuthStateContainer extends ConsumerWidget {
  const AuthStateContainer({super.key});

  Widget bioCheckview() {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(Images.bioasset, fit: BoxFit.cover),
        ),
       
      ],
    );
  }

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      authControllerProivder.select((s) => s.authScreenState),
    );
    return switch (state) {
      AuthScreenState.initial =>UsePinContainer(),
      AuthScreenState.password =>UsePassContainer(),
      AuthScreenState.pin => UsePinContainer(),
      AuthScreenState.bioauth => bioCheckview(),
      AuthScreenState.authenticated => EntriesScreen(),
      AuthScreenState.loading=>LoadingIndicator()
    };
  }
}
