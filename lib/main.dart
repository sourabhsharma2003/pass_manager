import 'package:flutter/material.dart';
import 'package:password_manager/app.dart';
import 'package:password_manager/src/core/app_mode/app_mode.dart';

import 'package:password_manager/src/core/theme/theme.dart';

void main() async {
 await AppMode.normalMode();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darktheme,
      home: const Home(),
    );
  }
}
