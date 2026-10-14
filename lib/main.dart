import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/app.dart';

import 'package:password_manager/src/core/theme/theme.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
void main() async {
  sqfliteFfiInit();
  databaseFactory=  databaseFactoryFfi;

 /* final db = await TestDbHelper().init();
  final datasource = EntryDatasorce();
  await datasource.init(customdb: db);*/
  runApp(
    ProviderScope(
     /* overrides: [
        entryDataprovider.overrideWith((ref) {
          return datasource;
        }),
      ],*/
      child: const MainApp(),
    ),
  );
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
