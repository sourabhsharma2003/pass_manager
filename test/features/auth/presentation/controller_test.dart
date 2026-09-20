import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/src/features/auth/data/auth_repo_impl.dart';
import 'package:password_manager/src/features/auth/data/biometric_service.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:password_manager/src/features/auth/presentation/providers/auth_controllers.dart';
import 'package:password_manager/src/features/auth/presentation/providers/state.dart';

import '../data/bio_test.dart';
import '../data/fake_storage.dart';

late ProviderContainer container;
AuthState get state => container.read(authControllerProivder);
AuthController get controller =>
    container.read(authControllerProivder.notifier);
void main() {
  late FakeLocalAuth fakelocalAuth;
  late AuthUseCases useCases;
  late Fakestorage fakestorage;

  setUp(() {
    fakelocalAuth = FakeLocalAuth();
    fakestorage = Fakestorage();
    useCases = AuthUseCases(
      AuthRepoImpl(
        StorageService(fakestorage),
        BiometricService(fakelocalAuth),
      ),
    );
    container = ProviderContainer(
      overrides: [
        authControllerProivder.overrideWith(() => AuthController(useCases)),
      ],
    );
    addTearDown(container.dispose);
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
    final result = controller.verify();
    expect(state.authScreenState, AuthScreenState.loading);

    await result;

    expect(state.error, isNotNull);
    expect(state.authScreenState, AuthScreenState.initial);
  });
  test('Riverpod: Verify if  pin exists', () async {
    await controller.savePinAndPass('pass', '3156');

    final result = controller.verify();
    expect(state.authScreenState, AuthScreenState.loading);
   
    await result;

    expect(state.authScreenState, AuthScreenState.bioauth);
  });

  test('Riverpod: save pin and pass test', () async {
    final save = controller.savePinAndPass('test', '2255');

    expect(state.authScreenState, AuthScreenState.loading);

    await save;

    expect(state.authScreenState, AuthScreenState.authenticated);
  });

  test('Riverpod:BioAuth if avaible and succes', () async {
    stub(true, true);

    final auth = controller.bioAuth();

    expect(state.authScreenState, AuthScreenState.loading);
    await auth;

    expect(state.authScreenState, AuthScreenState.authenticated);
  });

  test('Riverpod EdgeCase: BioAuth Available but cancelled', () async {
    stub(false, true);

    final auth = controller.bioAuth();
    expect(state.authScreenState, AuthScreenState.loading);
    await auth;

    expect(state.authScreenState, AuthScreenState.pin);
  });
  test('Riverpod EdgeCase: BioAuth NotAvailable', () async {
    stub(false, false);

    final auth = controller.bioAuth();
    expect(state.authScreenState, AuthScreenState.loading);

    await auth;

    expect(state.error, isNotNull);
    expect(state.authScreenState, AuthScreenState.pin);
  });

  test('Riverpod: login with right pin', () async {
    await controller.savePinAndPass('test', '2255');
    final readpin = controller.logviaPin('2255');
    expect(state.authScreenState, AuthScreenState.loading);
    await readpin;

    expect(state.authScreenState, AuthScreenState.authenticated);
  });

  test('Riverpod: login with wrong pin', () async {
    await controller.savePinAndPass('pass', '1235');

    final wrongpin = controller.logviaPin('5555');
    expect(state.authScreenState, AuthScreenState.loading);
    await wrongpin;

    expect(state.error, isNotNull);
  });

  test('Riverpod: login with right and wrong pass', () async {
    await controller.savePinAndPass('test', '2255');

    final rightpin = controller.loginviaPassword('test');
    expect(state.authScreenState, AuthScreenState.loading);
    await rightpin;

    expect(state.authScreenState, AuthScreenState.authenticated);

    final wrongpass = controller.loginviaPassword('wrongpass');
    expect(state.authScreenState, AuthScreenState.loading);
    await wrongpass;

    expect(state.error, isNotNull);
    expect(state.authScreenState, AuthScreenState.password);
  });

  test('Riverpod:On Tap Usepassword', () {
    controller.usepass();
    expect(state.authScreenState, AuthScreenState.password);
  });
}
