import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Fields extends StatelessWidget {
  final TextInputAction? textInputAction;
  final String? hintext;
  final TextEditingController? controller;
  final Function(String)? onfieldsubmitted;
  final int? maxlength;
  final String? errorText;
  final bool obscuretext;
  final Widget? suffixicon;
  final double? letterspacing;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const Fields({
    super.key,
    this.controller,
    this.maxlength,
    this.suffixicon,
    this.letterspacing,
    this.obscuretext = false,
    this.textInputAction,
    this.hintext,
    this.onfieldsubmitted,
    this.keyboardType,
    this.inputFormatters,
    this.errorText,
  });

  OutlineInputBorder normalborder(double width) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: const Color.fromARGB(255, 243, 205, 33),
        width: width,
      ),
    );
  }

  OutlineInputBorder errorborder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: const Color.fromARGB(255, 214, 2, 2),
        width: 0.3,
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintStyle: TextStyle(fontSize: 12),
      hintText: hintext,
      suffixIcon: suffixicon,
      enabledBorder: normalborder(0.3),
      focusedBorder: normalborder(0.6),
      errorBorder: errorborder(),
      errorText: errorText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscuretext,
        onFieldSubmitted: onfieldsubmitted,

        textInputAction: textInputAction,
        decoration: inputDecoration(),
        style: TextStyle(letterSpacing: letterspacing),
        maxLength: maxlength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
