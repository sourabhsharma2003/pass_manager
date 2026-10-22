import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color bgcolor;
  final Widget child;
  final VoidCallback onTap;
  const Button({
    super.key,
    required this.bgcolor,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton( style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero), backgroundColor:WidgetStatePropertyAll(bgcolor),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder( borderRadius: BorderRadius.all(const Radius.circular(4))))),onPressed: onTap, child: child);
  }
}
