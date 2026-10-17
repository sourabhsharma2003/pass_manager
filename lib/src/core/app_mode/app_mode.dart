import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/main.dart';
import 'package:password_manager/src/core/mocks/mock_db_initlizer.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';

abstract class AppMode {
 static Future<void> testMode() async {
    sqfliteFfiInit();
    databaseFactory=  databaseFactoryFfi;

  final db = await TestDbHelper().init();
  final datasource = EntryDatasorce();
  await datasource.init(customdb: db);
  runApp(
    ProviderScope(
      overrides: [
        entryDataprovider.overrideWith((ref) {
          return datasource;
        }),
      ],
      child: const MainApp(),
    ),
  );
  }

 static  Future<void>normalMode()async{
    sqfliteFfiInit();
    databaseFactory=  databaseFactoryFfi;
    runApp(
    ProviderScope(
     
      child: const MainApp(),
    ),
  );
  }
}
