import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/entries/data/entity_model.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';
import 'package:password_manager/src/features/entries/domain/entry_repo.dart';
import 'package:password_manager/src/features/entries/domain/entry_use_cases.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';
import 'package:password_manager/src/features/entries/presentation/screen/entries_screen.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/entry_card.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/popup_delete_button.dart';
import 'package:uuid/uuid.dart';

void main() {
  late Uuid uuid;
  late EntryRepo repo;
  late EntryUseCases useCases;
  late Widget proiderscope;

  

  setUp(() async {
    uuid = Uuid();
    repo = MockEntryRepo(uuid);
    useCases = EntryUseCases(repo);
    proiderscope = ProviderScope(
      overrides: [entryUsecasesProvider.overrideWith((_) => useCases)],
      child: MaterialApp(home: EntriesScreen()),
    );
  });
  Future<void> addentry(
    WidgetTester tester, {
    String? name,
    String? email,
    String? pass,
    String? category,
  }) async {
    final button = find.byKey(WidgetKeys.addEntrybutton);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(WidgetKeys.entrynamefield), name ?? '');
    await tester.pump();

    await tester.enterText(
      find.byKey(WidgetKeys.entryMailorUserfield),
      email ?? '',
    );
    await tester.pump();

    await tester.enterText(
      find.byKey(WidgetKeys.entrypassfield),
      pass ?? 'Saurabh@15158458',
    );
    await tester.pump();
    final dropdown = find.byKey(WidgetKeys.dropdowncategory);
    await tester.tap(dropdown);
    await tester.pumpAndSettle();
    final dropdownoption = find.text(category??'others',).first;
    expect(dropdownoption, findsAtLeast(1));
    await tester.tap(dropdownoption,warnIfMissed: false);
    await tester.pumpAndSettle();
    final save = find.byKey(WidgetKeys.saveEntrybutton);
    expect(save, findsOneWidget);
    await tester.ensureVisible(save);
    await tester.pumpAndSettle();

    await tester.tap(save);
    await tester.pumpAndSettle();
  }

  testWidgets('Entry screen : initial view ', (tester) async {
    
    await tester.pumpWidget(proiderscope);
    await tester.pumpAndSettle();
    expect(find.byKey(WidgetKeys.entryEmptyWidget), findsOneWidget);
  });
  testWidgets('Entry screen : loaded view ', (tester) async {
    
    await tester.pumpWidget(proiderscope);
    await tester.pumpAndSettle();
     await addentry(
      tester,
      name: 'Saurabh',
      email: 'Saurabh@gmail',
      pass: 'Saurabh#)15515',
      category: 'Personal'
    );
    expect(find.byKey(WidgetKeys.entryCategoryWidget), findsOneWidget);
  });

  testWidgets('Entry screen : bottom sheet render test ', (tester) async {
    await tester.pumpWidget(proiderscope);
    await tester.pumpAndSettle();
    final button = find.byKey(WidgetKeys.addEntrybutton);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();

    final namefield = find.byKey(WidgetKeys.addEntrybutton);
    expect(namefield, findsOneWidget);
  });

  testWidgets('Entry screen : add entry test', (tester) async {
    await tester.pumpWidget(proiderscope);
    await tester.pumpAndSettle();

    await addentry(
      tester,
      name: 'Saurabh',
      email: 'Saurabh@gmail',
      pass: 'Saurabh#)15515',
      category: 'Personal'
    );

    expect(find.byType(EntryCard), findsOneWidget);
  });

  testWidgets('Entry Screen: delete entry test', (tester) async {
    await tester.pumpWidget(proiderscope);
    await tester.pumpAndSettle();
    await addentry(
      tester,
      name: 'Saurabh',
      email: 'Saurabh@gmail',
      pass: 'Saurabh#)15515',
      category: 'Personal'
    );
    await addentry(
      tester,
      name: 'Sachin',
      email: 'Sachin@gmail',
      pass: 'Saurabh#)15515',
      category:'Work'
    );
    final items = find.byType(EntryCard);
    expect(items, findsExactly(2));
    final target = find.byType(PopupDeleteButton).at(1);
    await tester.tap(target);
    await tester.pumpAndSettle();
    final delete = find.text('Delete');
    await tester.tap(delete);
    await tester.pumpAndSettle();
    expect(items, findsExactly(1));
  });
}

class MockEntryRepo extends EntryRepo {
  final Uuid uuid;
  MockEntryRepo(this.uuid);
  List<EntryDomain> entries = [];
  @override
  Future<Result<void>> deleteEntry(String id) async {
    entries.removeWhere((test) => test.id == id);
    return Result.success(null);
  }

  @override
  Future<Result<List<EntryDomain>>> getEntries() async {
    return Result.success(entries);
  }

  @override
  Future<Result<void>> saveEntry(EntryDomain domain) async {
    final id = uuid.v4();
    final entry = EntryModel.fromdomain(domain).copyWith(id: id);
    entries.add(entry.todomain());
    return Result.success(null);
  }

  Future<Result<void>> deleteDatabase() {
    // TODO: implement deleteDatabase
    throw UnimplementedError();
  }
}
