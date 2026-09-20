import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/auth/presentation/providers/auth_controllers.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/fields.dart';

class UsePassContainer extends ConsumerStatefulWidget {
  const UsePassContainer({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _UsePassContainer();
  }
}

class _UsePassContainer extends ConsumerState<UsePassContainer> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget passfield() {
    final state = ref.watch(
      authControllerProivder.select((s) => s.obscure.loginpassobscure),
    );
    return Fields(
      obscuretext: state,
      hintext: 'Password',
      controller: controller,
      suffixicon: IconButton(
        onPressed: () {
          ref.read(authControllerProivder.notifier).obScureLoginPass();
        },
        icon: Icon(state ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }

  Widget login() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          ref
              .read(authControllerProivder.notifier)
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
          ref
              .read(authControllerProivder.notifier)
              .usepin();
        },
        child: Text('Back to use pin '),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [passfield(), login(),usePin()]);
  }
}
