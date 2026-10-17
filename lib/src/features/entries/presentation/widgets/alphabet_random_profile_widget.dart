import 'dart:math';

import 'package:flutter/material.dart';

class AlphabetRandomProfileWidget extends StatelessWidget {
  final String name;
  const AlphabetRandomProfileWidget({super.key, required this.name});

  Color _bgColor() {
    final rand=Random().nextInt(360);
    final hash = name.hashCode*rand;
    final hue = (hash % 360).abs().toDouble();
    final hsl = HSLColor.fromAHSL(1.0, hue, 0.45, 0.45).toColor();
    return hsl;
  }

  Color _firstAlphabetColor(Color color) {
    return HSLColor.fromColor(color).withLightness(0.95).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: 20, backgroundColor: _bgColor(),child: Text(name[0],style: TextStyle(color: _firstAlphabetColor(_bgColor()), fontSize: 15),),);
  }
}
