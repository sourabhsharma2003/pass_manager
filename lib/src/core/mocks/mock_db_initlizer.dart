import 'package:password_manager/src/core/constants/entry_sql_constant.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';


class TestDbHelper {
  Database? _db;


  Future<Database> init() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    _db = await databaseFactory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute(EntrySqlConstant.table);
        },
      ),
    );
    return _db!;
  }

 

  /// Reset DB for fresh test runs
  Future<void> reset() async {
    await _db?.close();
    _db = null;
  }
}
