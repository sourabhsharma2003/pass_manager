import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/src/core.dart';
import 'package:password_manager/src/features/auth/presentation/providers/auth_controllers.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/fields.dart';

class CreatePassPinState extends ConsumerStatefulWidget {
  const CreatePassPinState({super.key});

  @override
  ConsumerState<CreatePassPinState> createState() => _CreatePassPinState();
}

class _CreatePassPinState extends ConsumerState<CreatePassPinState> {
  final TextEditingController pincontroler = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  @override
  void dispose() {
    pincontroler.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  Widget pinfield() {
    final obscurebool = ref.watch(
      authControllerProivder.select((s) => s.obscure!),
    );
    return Fields(
      controller: pincontroler,
      maxlength: 4,
      hintext: 'New Pin',
      obscuretext: obscurebool.createpinobscure,
      letterspacing: 4,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

      suffixicon: IconButton(
        onPressed: () {
          ref.read(authControllerProivder.notifier).obScurepin();
        },
        icon: Icon(obscurebool.createpinobscure ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }

  Widget passfield() {
    final obscurebool = ref.watch(
      authControllerProivder.select((s) => s.obscure!),
    );
    return Fields(
      obscuretext: obscurebool.createpassobscure,
      hintext: 'New Password',
      controller: passcontroller,
      suffixicon: IconButton(
        onPressed: () {
          ref.read(authControllerProivder.notifier).obScureCreatepass();
        },
        icon: Icon(obscurebool.createpassobscure ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }

  Widget create() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          ref
              .read(authControllerProivder.notifier)
              .savePinAndPass(passcontroller.text, pincontroler.text);
        },
        child: Text('Create'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [pinfield(), passfield(), create()]);
  }
}
