import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/auth/presentation/providers/auth_controllers.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/custom_pin_field.dart';

class UsePinContainer extends ConsumerStatefulWidget {
  const UsePinContainer({super.key});

  @override
  ConsumerState<UsePinContainer> createState() => _UsePinContainerState();
}

class _UsePinContainerState<T> extends ConsumerState<UsePinContainer> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<T?> errordialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Wrong pin'),
        content: Text('Wrong pin:, Retry or use password'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('retry'),
          ),
        ],
      ),
    );
  }

  Widget _login() {
    return ElevatedButton(
      onPressed: () {
        ref
            .read(authControllerProivder.notifier)
            .logviaPin(controller.text.trim());

        if (ref.read(authControllerProivder.select((s) => s.error != null))) {
          errordialog();
        }
      },
      child: SizedBox( width: 200,height: 40, child:Align(alignment: Alignment.center,child:  Text('Login',))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 70,
          child: CustomPinField(
            controller: controller,
            textInputAction: TextInputAction.done,
            hintext: '****',
          ),
        ),
         const SizedBox(height: 40),
        _login(),

       

        const SizedBox(height: 20),

        TextButton(
          onPressed: () {
            ref.read(authControllerProivder.notifier).usepass();
          },
          child: Text('Use Password Instead'),
        ),
      ],
    );
  }
}
