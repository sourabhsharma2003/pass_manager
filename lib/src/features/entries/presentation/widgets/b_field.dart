import 'package:flutter/material.dart';

class BFields extends StatefulWidget {
  final TextInputAction? textInputAction;
  final String? hintext;
  final TextEditingController? controller;
  final Function(String)? onfieldsubmitted;

  final String? Function(String?)? validator;

  final Color? fieldBorderCOlor;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  const BFields({
    super.key,
    this.fieldBorderCOlor,
    this.controller,
    this.contentPadding,
    this.focusNode,
    this.textInputAction,
    this.hintext,
    this.onfieldsubmitted,

    this.validator,
  });

  @override
  State<BFields> createState() => _BFieldsState();
}

class _BFieldsState extends State<BFields> {
  final _key = GlobalKey();
  void autoScrollF() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final context = _key.currentContext;
    if (context != null&& context.mounted) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(() {
      if (widget.focusNode!.hasFocus) {
        autoScrollF();
      }
    });
  }

  OutlineInputBorder normalborder(double width) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: widget.fieldBorderCOlor ?? Colors.amber,
        width: width,
      ),
    );
  }

  OutlineInputBorder errorborder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: const Color.fromARGB(255, 255, 116, 116),
        width: 0.3,
      ),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      helperText: '',
      helperStyle: TextStyle(fontSize: 9),
      contentPadding: widget.contentPadding,
      hintStyle: TextStyle(
        fontSize: 12,
        color: const Color.fromARGB(255, 84, 83, 83),
      ),
      hintText: widget.hintext,

      enabledBorder: normalborder(0.3),
      focusedBorder: normalborder(0.6),
      errorBorder: errorborder(),
      border: errorborder(),
      errorStyle: TextStyle(fontSize: 9),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        style: TextStyle(fontSize: 12),
        onFieldSubmitted: widget.onfieldsubmitted,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        decoration: inputDecoration(),
      ),
    );
  }
}
