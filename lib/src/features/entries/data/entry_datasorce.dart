import 'package:password_manager/src/core/config/env.dart';
import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/entries/data/entity_model.dart';
import 'package:password_manager/src/core/constants/entry_sql_constant.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class EntryDatasorce {
  Database? _database;

  Future<Database> init({Database? customdb}) async {
    if (customdb != null) {
      _database = customdb;
      return _database!;
    }
    if (_database != null) return _database!;
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'entry_db.db');
    final db = await openDatabase(
      password: Env.dbkey,
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(EntrySqlConstant.table);
      },
    );
    _database = db;

    return db;
  }

  Future<Result<void>> saveEntry(EntryModel entry) async {
    try {
      final db = await init();

      await db.insert('entries', entry.todb());
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<List<EntryModel>>> getentry() async {
    try {
      final db = await init();
      final data = await db.query('entries');
      if (data.isEmpty) {
        return Result.success([]);
      }
      return Result.success(data.map((d) => EntryModel.fromdb(d)).toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> deleteEntry(String id) async {
    try {
      final db = await init();
      await db.delete('entries', where: 'id=?', whereArgs: [id]);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<void>> deleteDatabase() async {
    try {
      final db = await init();
      await db.delete('entries');
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  void resetdbforTest() {
    _database = null;
  }
}
