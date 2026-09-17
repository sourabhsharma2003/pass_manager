import 'package:flutter/material.dart';

class VaultContainer extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final double scale;
  
  final Color? color;
  const VaultContainer({
    super.key,
    required this.icon,
    this.onTap,
    required this.scale,
    
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: scale,
        width: scale,
        decoration: BoxDecoration(
          color: color?.withValues(alpha: 0.1),
          border: Border.all(color: color??Colors.amber, width: 1),
          borderRadius: BorderRadius.all(const Radius.circular(16)),
         
        ),
        child: Icon(icon),
      ),
    );
  }
}
