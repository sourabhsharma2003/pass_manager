import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/app.dart';
import 'package:password_manager/src/core/theme/theme.dart';
void main() {
  runApp(
    ProviderScope(child: 
    const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:AppTheme.darktheme,
      home: const Home()
    );
  }
}
