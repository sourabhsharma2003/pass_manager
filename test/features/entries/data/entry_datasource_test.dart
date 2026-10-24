import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/core/mocks/mock_entries.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';
import 'package:password_manager/src/core/constants/entry_sql_constant.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Database db;
  late EntryDatasorce entryDatasorce;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(EntrySqlConstant.table);
    entryDatasorce = EntryDatasorce();
    await entryDatasorce.init(customdb: db);
  });
  tearDown(() async {
    await db.close();
    entryDatasorce.resetdbforTest();
  });

  test('Database:save entry test', () async {
    final result = await entryDatasorce.saveEntry(MockEntries.entry);

    expect(result.error, isNull);
    expect(result.isSuccess(), true);
  });

  test('Database:read entry test', () async {
    await entryDatasorce.saveEntry(MockEntries.entrywithid);
    final result = await entryDatasorce.getentry();
    expect(result.isSuccess(), true);

    expect(result.data?.first.id, MockEntries.entrywithid.id);
  });

  test('Database:delete entry test', () async {
    await entryDatasorce.saveEntry(MockEntries.entrywithid);

    final result = await entryDatasorce.deleteEntry(MockEntries.entrywithid.id);
    expect(result.isSuccess(), true);
    final db = await entryDatasorce.getentry();
    expect(db.data?.isEmpty, true);
  });

  test('Database Edgecase:reading empty db', () async {
    final result = await entryDatasorce.getentry();
    expect(result.data?.isEmpty, true);
  });
}
