import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/local/auth_local_ui_providers.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/fields.dart';

class UserPassView extends ConsumerStatefulWidget {
  const UserPassView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UserPassView();
  }
}

class _UserPassView extends ConsumerState<UserPassView> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget passfield() {
    final state = ref.watch(
      authLocalUiProvider.select((s) => s.loginpassobscure),
    );
    return Fields(
      key: WidgetKeys.loginpassfield,
      obscuretext: state,
      hintext: 'Password',
      controller: controller,
      onfieldsubmitted: (v)=>ref
              .read(authNotifierProvider.notifier)
              .loginviaPassword(controller.text.trim()),
      suffixicon: IconButton(
        onPressed: () {
          ref.read(authLocalUiProvider.notifier).loginpassObscure();
        },
        icon: Icon(state ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }

  

  Widget login() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        key: WidgetKeys.loginpassbutton,
        onPressed: () {
          ref
              .read(authNotifierProvider.notifier)
              .loginviaPassword(controller.text.trim());
        },
        child: Text('Login'),
      ),
    );
  }

  Widget usePin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () {
          ref.read(authNotifierProvider.notifier).usepin();
        },
        child: Text('Back to use pin '),
      ),
    );
  }
 Widget forgotbutton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: () {
          ref.read(authNotifierProvider.notifier).goForgot();
        },
        child: Text('Forgot?', style: TextStyle(fontSize: 12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        passfield(),
        forgotbutton(),
        const SizedBox(width: 50, child: Divider()),
        
        login(),
        usePin(),
      ],
    );
  }
}
