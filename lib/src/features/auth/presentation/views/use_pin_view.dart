import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/colors.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/custom_pin_field.dart';

class UsePinView extends ConsumerStatefulWidget {
  const UsePinView({super.key});

  @override
  ConsumerState<UsePinView> createState() => _UsePinContainerState();
}

class _UsePinContainerState extends ConsumerState<UsePinView> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _login() {
    return ElevatedButton(
      onPressed: () {
        ref
            .read(authNotifierProvider.notifier)
            .logviaPin(controller.text.trim());
      },
      child: SizedBox(
        width: 200,
        height: 40,
        child: Align(
          alignment: Alignment.center,
          child: Text('Login', style: TextStyle(color: AppColors.primary)),
        ),
      ),
    );
  }

  Widget _pinFied() {
    return SizedBox(
      width: 70,
      child: CustomPinField(
        key: WidgetKeys.loginpinfield,
        controller: controller,
        onChanged: (v) {
          if (v.length == 4) {
            ref
                .read(authNotifierProvider.notifier)
                .logviaPin(controller.text.trim());
          }
        },
        onfieldsubmitted: (p0) {
          ref
              .read(authNotifierProvider.notifier)
              .logviaPin(controller.text.trim());
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputAction: TextInputAction.done,
        hintext: '****',
      ),
    );
  }

  Widget forgotbutton() {
    return TextButton(
      onPressed: () {
        ref.read(authNotifierProvider.notifier).goForgot();
      },
      child: Text('Forgot?', style: TextStyle(fontSize: 12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:  Column(
      children: [
        _pinFied(),
        const SizedBox(width: 100, child: Divider()),

        forgotbutton(),
        const SizedBox(height: 40),
        _login(),

        const SizedBox(height: 20),

        TextButton(
          key: WidgetKeys.usePasswordbuttom,
          onPressed: () {
            ref.read(authNotifierProvider.notifier).usepass();
          },
          child: Text('Use Password Instead'),
        ),
      ],
    ));
  }
}
