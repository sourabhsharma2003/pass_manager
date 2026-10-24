import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';
import 'package:password_manager/src/features/entries/data/entry_repo_impl.dart';
import 'package:password_manager/src/core/constants/entry_sql_constant.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:uuid/uuid.dart';

import '../../../../lib/src/core/mocks/mock_entries.dart';

void main() {
  late EntryRepoImpl repo;
  late EntryDatasorce datasorce;
  late Database db;
  late Uuid uui;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(EntrySqlConstant.table);
    datasorce = EntryDatasorce();
    await datasorce.init(customdb: db);
    uui = Uuid();
    repo = EntryRepoImpl(data: datasorce, uuid: uui);
  });

  tearDown(() async {
    await db.close();
    datasorce.resetdbforTest();
  });

  test('Entry Repo: Test Uuid working', () async {
    final save = await repo.saveEntry(MockEntries.entry.todomain());
    expect(save.isSuccess(), true);

    final result = await repo.getEntries();

    expect(result.isSuccess(), true);
    expect(result.data?.first.id.isNotEmpty, true);
    print('Gentrated Uuid=${result.data?.first.id}');
  });
}
