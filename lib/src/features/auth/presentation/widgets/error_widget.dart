import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onTap;
  final String? actionName;
  const ErrorDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
    required this.actionName
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [actionName==null? const SizedBox.shrink() :TextButton(onPressed: onTap, child: Text(actionName!))],
    );
  }
}
