import 'package:flutter/material.dart';
import 'package:password_manager/src/core/constants/colors.dart';
import 'package:password_manager/src/core/constants/images.dart';

class EmptyView extends StatelessWidget {
  final String text;
  const EmptyView({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column( children: [
        const SizedBox(height: 100,),
        SizedBox( height:100,width:100,child: Image.asset(Images.emptyEntries))
        ,Text(text,style: TextStyle(fontSize: 14,color: AppColors.primary,),)
      ],),
    );
  }
}
