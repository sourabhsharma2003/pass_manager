import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';
import 'package:password_manager/src/features/entries/data/entry_repo_impl.dart';
import 'package:password_manager/src/core/constants/entry_sql_constant.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';
import 'package:password_manager/src/features/entries/domain/entry_repo.dart';
import 'package:password_manager/src/features/entries/domain/entry_use_cases.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';
import 'package:uuid/uuid.dart';

import '../../../../lib/src/core/mocks/mock_entries.dart';

void main() {
  late Uuid uuid;
  late EntryDatasorce entryDatasorce;
  late EntryRepo repo;
  late Database db;
  late EntryUseCases entryUseCases;

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  setUp(() async {
    db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute(EntrySqlConstant.table);
    uuid = Uuid();
    entryDatasorce = EntryDatasorce();
    await entryDatasorce.init(customdb: db);
    repo = EntryRepoImpl(data: entryDatasorce, uuid: uuid);
    entryUseCases = EntryUseCases(repo);
  });

  tearDown(() async {
    await db.close();
  });

  test('GetEntryUseCases: Test if return  grouped List', () async {
   

    await entryUseCases.addNewEntry.call(MockEntries.entry.todomain());
    final result = await entryUseCases.getEntries.call();
    expect(result.isSuccess(), true);
    expect(result.data?.keys.first, EntryCategory.others);
    expect(result.data?.values.first.first.password, MockEntries.entry.password);
  });

  test('SearchEntryUseCase: Test if query return searched entry', () async {
   
    await entryUseCases.addNewEntry.call(MockEntries.entry.todomain());
    await entryUseCases.addNewEntry.call(MockEntries.entry2.todomain());
    final result = await entryUseCases.searchEntry.call('e');
    expect(result.data!.length, 1);
    expect(result.data![0].sitename, MockEntries.entry2.sitename);
  });

  test('SearchEntryUseCase: Test if query wrong (no entry found)', ()async {
     
    await entryUseCases.addNewEntry.call(MockEntries.entry.todomain());
    await entryUseCases.addNewEntry.call(MockEntries.entry.todomain());
    final result = await entryUseCases.searchEntry.call('wr');
    expect(result.data,[]);
    
  });
}
