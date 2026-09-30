import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/colors.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/local/auth_local_ui_providers.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/fields.dart';

class CreateForgotPinPassView extends ConsumerStatefulWidget {
  const CreateForgotPinPassView({super.key});

  @override
  ConsumerState<CreateForgotPinPassView> createState() =>
      _CreateForgotPinPassView();
}

class _CreateForgotPinPassView extends ConsumerState<CreateForgotPinPassView> {
  final TextEditingController pincontroler = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  @override
  void dispose() {
    pincontroler.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  Widget pinfield() {
    final _obscurepin = ref.watch(
      authLocalUiProvider.select((s) => s.createpinobscure),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Fields(
        key: WidgetKeys.createPin,
        controller: pincontroler,
        maxlength: 4,
        hintext: 'New Pin',
        obscuretext: _obscurepin,
        letterspacing: 4,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

        suffixicon: IconButton(
          onPressed: () {
            ref.read(authLocalUiProvider.notifier).createpinObscure();
          },
          icon: Icon(_obscurepin ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }

  Widget passfield() {
    final obscurebool = ref.watch(
      authLocalUiProvider.select((s) => s.createpassobscure),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Fields(
        key: WidgetKeys.createPass,
        obscuretext: obscurebool,
        hintext: 'New Password',
        controller: passcontroller,
        suffixicon: IconButton(
          onPressed: () {
            ref.read(authLocalUiProvider.notifier).createpassobscure();
          },
          icon: Icon(
            obscurebool
                ? Icons.visibility_off
                : Icons.visibility,
          ),
        ),
      ),
    );
  }

  Widget warningContainer(String? forgot) {
    return forgot != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: AppColors.primary, width: 0.4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                forgot,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget createForgotbutton(String? forgot) {
    final notifier = ref.read(authNotifierProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        key: WidgetKeys.createButton,
        onPressed: () {
          forgot != null
              ? notifier.forgot(passcontroller.text, pincontroler.text)
              : notifier.createPinAndPass(
                  passcontroller.text,
                  pincontroler.text,
                );
        },
        child: Text(
          forgot != null ? "Set New" : 'Create',
          style: TextStyle(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget goback(String? forgot) {
    return forgot != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).usepin();
              },
              child: Text('Go Back', style: TextStyle(color: AppColors.blue)),
            ),
          )
        : const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final forgot = ref.watch(authNotifierProvider.select((s) => s.forgot));
    return Column(
      children: [
        warningContainer(forgot),
        pinfield(),
        passfield(),
        const SizedBox(width :180,child: Divider()),
        createForgotbutton(forgot),
        goback(forgot),
         
      ],
    );
  }
}
