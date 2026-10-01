import 'package:flutter/material.dart';

class BioAuthWidget extends StatelessWidget {
  final String image;
  const BioAuthWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Image.asset(image, fit: BoxFit.cover),
    );
  }
}
