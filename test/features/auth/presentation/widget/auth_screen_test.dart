import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/src/core/appshell/appshell.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/auth/domain/repo/auth_repo.dart';
import 'package:password_manager/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';

void main() {
  late Widget providerscope;
  late AuthUseCases useCases;
  late AuthRepo repo;
  setUp(() {
    repo = MockAuthRepo();
    useCases = AuthUseCases(repo);
    providerscope = ProviderScope(
      overrides: [authUseCasesProvider.overrideWith((_) => useCases)],
      child: MaterialApp(home: Appshell()),
    );
  });

  tearDown(() {
    providerscope = const SizedBox.shrink();
  });
  testWidgets('Auth Screen : Startup Test initial screen if pin wont exist', (
    tester,
  ) async {
    when(() => repo.readPin()).thenAnswer((_) async => Result.failure(''));
    await tester.pumpWidget(providerscope);

    expect(find.byKey(WidgetKeys.authScreen), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.createPasspinView), findsOneWidget);
  });

  testWidgets('Auth Screen : if pin exist', (test) async {
    when(() => repo.readPin()).thenAnswer((_) async => Result.success('pin'));
    when(
      () => repo.isBioAuthAvaible(),
    ).thenAnswer((_) async => Result.failure('nill'));

    await test.pumpWidget(providerscope);
    await test.pumpAndSettle();
    expect(find.byKey(WidgetKeys.usePinView), findsOneWidget);
  });

  testWidgets('Auth Screen: bioauth available and unauthenticated', ((
    tester,
  ) async {
    when(() => repo.readPin()).thenAnswer((_) async => Result.success('pin'));

    when(
      () => repo.isBioAuthAvaible(),
    ).thenAnswer((_) async => Result.success(null));

    when(() => repo.bioAuth()).thenAnswer((_) async => Result.failure('error'));

    await tester.pumpWidget(providerscope);
    await tester.pumpAndSettle();
    expect(find.byKey(WidgetKeys.usePinView), findsOneWidget);
  }));

  testWidgets('Auth Screen: bioauth available and authenticated', ((
    tester,
  ) async {
    when(() => repo.readPin()).thenAnswer((_) async => Result.success('pin'));

    when(
      () => repo.isBioAuthAvaible(),
    ).thenAnswer((_) async => Result.success(null));

    when(() => repo.bioAuth()).thenAnswer((_) async => Result.success(null));

    await tester.pumpWidget(providerscope);
    await tester.pumpAndSettle();
    expect(find.byKey(WidgetKeys.entryScreen), findsOneWidget);
  }));

  testWidgets('Auth Screen: login with right pin ', ((tester) async {
    when(() => repo.readPin()).thenAnswer((_) async => Result.success('3156'));

    when(
      () => repo.isBioAuthAvaible(),
    ).thenAnswer((_) async => Result.failure('error'));

    await tester.pumpWidget(providerscope);

    await tester.pumpAndSettle();

    final pinfield = find.byKey(WidgetKeys.loginpinfield);
    await tester.enterText(pinfield, '3156');
    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.entryScreen), findsOneWidget);
  }));

  testWidgets('Auth Screen: login with wrong pin ', ((tester) async {
    when(() => repo.readPin()).thenAnswer((_) async => Result.success('3156'));

    when(
      () => repo.isBioAuthAvaible(),
    ).thenAnswer((_) async => Result.failure('error'));

    await tester.pumpWidget(providerscope);

    await tester.pumpAndSettle();

    final pinfield = find.byKey(WidgetKeys.loginpinfield);
    await tester.enterText(pinfield, '4515');
    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.loginErrordialog), findsAtLeast(1));
  }));

  testWidgets('Auth Screen: login with right pass  ', ((tester) async {
    when(() => repo.readPin()).thenAnswer((_) async => Result.success('3156'));
    when(
      () => repo.readPass(),
    ).thenAnswer((_) async => Result.success('testpass'));
    when(
      () => repo.isBioAuthAvaible(),
    ).thenAnswer((_) async => Result.failure('error'));

    await tester.pumpWidget(providerscope);

    await tester.pumpAndSettle();

    final passbutton = find.byKey(WidgetKeys.usePasswordbuttom);
    await tester.ensureVisible(passbutton);

    await tester.tap(passbutton);
    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.usePasswordView), findsOneWidget);
    final passfield = find.byKey(WidgetKeys.loginpassfield);
    await tester.enterText(passfield, 'testpass');

    final passbuttom = find.byKey(WidgetKeys.loginpassbutton);
    await tester.tap(passbuttom);
    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.entryScreen), findsOneWidget);
  }));

  testWidgets('Auth Screen: login with wrong pass  ', ((tester) async {
    when(() => repo.readPin()).thenAnswer((_) async => Result.success('3156'));
    when(
      () => repo.readPass(),
    ).thenAnswer((_) async => Result.success('testpass'));
    when(
      () => repo.isBioAuthAvaible(),
    ).thenAnswer((_) async => Result.failure('error'));

    await tester.pumpWidget(providerscope);

    await tester.pumpAndSettle();

    final passbutton = find.byKey(WidgetKeys.usePasswordbuttom);
    await tester.ensureVisible(passbutton);

    await tester.tap(passbutton);
    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.usePasswordView), findsOneWidget);
    final passfield = find.byKey(WidgetKeys.loginpassfield);
    await tester.enterText(passfield, 'wrongpass');

    final passbuttom = find.byKey(WidgetKeys.loginpassbutton);
    await tester.tap(passbuttom);
    await tester.pumpAndSettle();

    expect(find.byKey(WidgetKeys.loginErrordialog), findsOneWidget);
  }));
}

class MockAuthRepo extends Mock implements AuthRepo {}
