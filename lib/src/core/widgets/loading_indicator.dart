import 'package:flutter/material.dart';
import 'package:password_manager/src/core/constants/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(color: AppColors.primary,strokeWidth: 2,),
      ),
    );
  }
}
