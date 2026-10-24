import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/src/core/constants/entry_sql_constant.dart';
import 'package:password_manager/src/features/auth/data/biometric_service.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/auth_notifier.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/providers.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/state.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';
import 'package:sqflite_common_ffi/sqflite_common_ffi.dart';

import '../../data/bio_test.dart';
import '../../data/storage_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FakeLocalAuth fakelocalAuth;
  late List<AuthState> states;
  late Fakestorage fakestorage;
  late ProviderContainer container;
  late AuthNotifier notifier;
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
    fakelocalAuth = FakeLocalAuth();
    fakestorage = Fakestorage();
    states = <AuthState>[];
    container = ProviderContainer(
      overrides: [
        entryDataprovider.overrideWith((_) => entryDatasorce),
        authSecureStorageprovider.overrideWith(
          (_) => StorageService(fakestorage),
        ),
        authbioServiceProvider.overrideWith(
          (_) => BiometricService(fakelocalAuth),
        ),
      ],
    );
    notifier = container.read(authNotifierProvider.notifier);
  });
  tearDown(() async {
    await db.close();
    states.clear();
    container.dispose();
  });
  void stub(bool isauthenticated, bool isavailble) {
    when(
      () => fakelocalAuth.canCheckBiometrics,
    ).thenAnswer((_) async => isavailble);
    when(
      () => fakelocalAuth.isDeviceSupported(),
    ).thenAnswer((_) async => isavailble);
    when(
      () => fakelocalAuth.authenticate(
        localizedReason: 'Authentication to unlock your vault',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      ),
    ).thenAnswer((_) async => isauthenticated);
  }

  test('Riverpod Edge case: Verify if pin wont exists', () async {
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await notifier.verify();
    sub.close();

    expect(states[1].authScreenState, AuthScreenState.loading);
    expect(states[2].authScreenState, AuthScreenState.initial);
  });
  test('Riverpod: Verify if  pin exists', () async {
    await notifier.createPinAndPass('pass', '3156');
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );

    await notifier.verify();
    sub.close();
    expect(states[1].authScreenState, AuthScreenState.loading);

    expect(states[2].authScreenState, AuthScreenState.bioauth);
  });

  test('Riverpod: save pin and save pass test', () async {
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await notifier.createPinAndPass('test', '2255');
    sub.close();
    expect(states[1].authScreenState, AuthScreenState.loading);
    expect(states[2].authenticated, true);
  });

  test('Riverpod:BioAuth if avaible and succes', () async {
    stub(true, true);
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await notifier.bioAuth();
    sub.close();

    expect(states[1].authScreenState, AuthScreenState.loading);
    expect(states[1].authenticated, false);

    expect(states[2].authenticated, true);
  });

  test('Riverpod EdgeCase: BioAuth Available but cancelled', () async {
    stub(false, true);
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );

    await notifier.bioAuth();

    sub.close();

    expect(states[1].authScreenState, AuthScreenState.loading);
    expect(states[2].authenticated, false);
    expect(states[2].authScreenState, AuthScreenState.pin);
  });
  test('Riverpod EdgeCase: BioAuth NotAvailable', () async {
    stub(false, false);
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await notifier.bioAuth();
    sub.close();
    expect(states[1].authScreenState, AuthScreenState.loading);

    expect(states[2].authScreenState, AuthScreenState.pin);

    expect(states[2].error, isNull);
  });

  test('Riverpod: login with right pin', () async {
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await notifier.createPinAndPass('test', '2255');
   
    
    await notifier.logviaPin('2255');
    sub.close();
    
    expect(states[2].authScreenState, AuthScreenState.loading);
    expect(states[3].authenticated, false);
    expect(states[4].authenticated, true);
  });

  test('Riverpod: login with wrong pin', () async {
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    await notifier.createPinAndPass('pass', '1235');
    await notifier.logviaPin('5555');
    sub.close();
    expect(states[1].authScreenState, AuthScreenState.loading);
    expect(states[1].authenticated, false);

    expect(states[4].error, isNotNull);
    expect(states[4].authenticated, false);
  });

  test('Riverpod: login with right and wrong pass', () async {
    await notifier.createPinAndPass('test', '2255');
    final sub = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );
    //right password
    await notifier.loginviaPassword('test');
    sub.close();

    expect(states[1].authScreenState, AuthScreenState.loading);
    expect(states[1].authenticated, false);

    expect(states[2].authenticated, true);
    states.clear();

    final sub2 = container.listen<AuthState>(
      authNotifierProvider,
      (prev, next) => states.add(next),
      fireImmediately: true,
    );

    await notifier.loginviaPassword('wrongpass');
    sub2.close();
    expect(states[1].authScreenState, AuthScreenState.loading);

    expect(states[2].error, isNotNull);
    expect(states[2].authenticated, false);
  });

  test('Riverpod:forgot test', () async {
    await notifier.createPinAndPass('critical ops', '3156');
    final sub = container.listen(authNotifierProvider, (prev, next) {
      states.add(next);
    });
    await notifier.forgot('testforgot', '4215');
    sub.close();
    expect(states[0].authScreenState, AuthScreenState.loading);

    expect(states[1].authenticated, true);
  });
}
