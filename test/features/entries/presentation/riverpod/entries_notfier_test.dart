

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/core/mocks/mock_entries.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';
import 'package:password_manager/src/core/constants/entry_sql_constant.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/entry_notifier.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/entry_states.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {
  late ProviderContainer container;
  late Database db;
  late EntryDatasorce datasorce;
  late List<EntryPageState> states;
  late EntryNotifier controller;

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  setUp(() async {
    states = <EntryPageState>[];

    db = await databaseFactory.openDatabase(inMemoryDatabasePath);

    await db.execute(EntrySqlConstant.table);

    datasorce = EntryDatasorce();

    await datasorce.init(customdb: db);

    container = ProviderContainer(
      overrides: [entryDataprovider.overrideWith((_) => datasorce)],
    );
    controller = container.read(entryNotifierProvider.notifier);
  });

  tearDown(() async {
    await db.close();
    container.dispose();
    states.clear();
  });
  test('EntryNotifierTest: initial state ,Empty entries', () async {
    container.listen(
      entryNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await controller.getEntries();

    expect(states[0].entryState, EntryState.initial);

    expect(states[0].entries, isNull);
    expect(states[1].entryState, EntryState.loading);
    expect(states[2].entryState, EntryState.initial);
  });

  test('EntryNotiferTest:When entries is not null', () async {
    container.listen(
      entryNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );

    await controller.addNewEntry(MockEntries.entry.todomain());

    expect(states[0].entryState, EntryState.initial);
    expect(states[1].entryState, EntryState.loading);
    expect(states[2].entries, isNotNull);
    expect(states[2].entryState, EntryState.loaded);
  });

  test('EntryNotifierTest:delete entry if only one entry exists', () async {
    container.listen(
      entryNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );

    await controller.addNewEntry(MockEntries.entry2.todomain());

    await controller.deleteEntry(states[2].entries!.values.first[0].id);

    expect(states[0].entryState, EntryState.initial);
    expect(states[1].entryState, EntryState.loading);
    expect(states[2].entryState, EntryState.loaded);
    expect(states[3].entryState, EntryState.initial);
  });

  test('EntryNotifierTest:delete entry if multiple  entry exists', () async {
    container.listen(
      entryNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );

    await controller.addNewEntry(MockEntries.entry.todomain());
    await controller.addNewEntry(MockEntries.entry2.todomain());
    await controller.deleteEntry(states[2].entries!.values.first[0].id);
    expect(states[0].entryState, EntryState.initial);
    expect(states[1].entryState, EntryState.loading);
    expect(states[2].entryState, EntryState.loaded);
    expect(states[3].entryState, EntryState.loading);
    expect(states[4].entryState, EntryState.loaded);
    expect(states[5].entryState, EntryState.loaded);
  });

  test('EntryNotfierTest:Querytest right keyword', () async {
    container.listen(
      entryNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await controller.addNewEntry(MockEntries.entry.todomain());
    await controller.searchEntries('s');
    expect(states[0].entryState, EntryState.initial);
    expect(states[1].entryState, EntryState.loading);
    expect(states[2].entryState, EntryState.loaded);
    expect(states[3].entryState, EntryState.loading);
    expect(states[4].entryState, EntryState.querLoaded);
  });

  test('EntryNotfierTest:Querytest wrong keyword', () async {
    container.listen(
      entryNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await controller.addNewEntry(MockEntries.entry.todomain());
    await controller.searchEntries('j');
    expect(states[0].entryState, EntryState.initial);
    expect(states[1].entryState, EntryState.loading);
    expect(states[2].entryState, EntryState.loaded);
    expect(states[3].entryState, EntryState.loading);
    expect(states[4].entryState, EntryState.noresult);
  });
}
