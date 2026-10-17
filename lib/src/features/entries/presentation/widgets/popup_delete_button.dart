import 'package:flutter/material.dart';

class PopupDeleteButton extends StatelessWidget {
  final VoidCallback onDelete;
  const PopupDeleteButton({super.key, required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      clipBehavior: Clip.antiAlias,
      offset: Offset(5, 16),
      shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(20))),
      popUpAnimationStyle: AnimationStyle(curve: Curves.easeOut,duration: Duration(milliseconds: 500)),
      itemBuilder: (context) {
        return [PopupMenuItem(onTap: onDelete, child: Text('Delete'))];
      },
    );
  }
}
