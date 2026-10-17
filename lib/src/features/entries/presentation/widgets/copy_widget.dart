import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyWidget extends StatefulWidget {
  final String text;
  const CopyWidget({super.key, required this.text});

  @override
  State<CopyWidget> createState() => _CopyWidgetState();
}

class _CopyWidgetState extends State<CopyWidget> {
  bool copy = false;

  void copymethod() {
    Clipboard.setData(ClipboardData(text: widget.text));
    setState(() {
      copy = true;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        copy = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      onPressed: copymethod,
      icon: Icon(copy ? Icons.check : Icons.copy, size: 15),
    );
  }
}
