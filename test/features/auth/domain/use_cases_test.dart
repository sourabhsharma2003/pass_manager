import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/src/features/auth/data/auth_repo_impl.dart';
import 'package:password_manager/src/features/auth/data/biometric_service.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/domain/use_cases/auth_use_cases.dart';

import '../data/bio_test.dart';
import '../data/storage_test.dart';

void main() {
  late Fakestorage fakestorage;
  late StorageService storageService;
  late BiometricService biometricService;
  late AuthRepoImpl repo;
  late FakeLocalAuth fakeLocalAuth;
  late AuthUseCases authUseCases;
  setUp(() {
    fakestorage = Fakestorage();
    storageService = StorageService(fakestorage);
    fakeLocalAuth = FakeLocalAuth();
    biometricService = BiometricService(fakeLocalAuth);
    repo = AuthRepoImpl(storageService, biometricService);
    authUseCases = AuthUseCases(repo);
  });

  void stub({bool? authenticated, bool? isavailble}) {
    when(
      () => fakeLocalAuth.canCheckBiometrics,
    ).thenAnswer((_) async => isavailble!);
    when(
      () => fakeLocalAuth.isDeviceSupported(),
    ).thenAnswer((_) async => isavailble!);

    when(
      () => fakeLocalAuth.authenticate(
        localizedReason: 'Authentication to unlock your vault',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      ),
    ).thenAnswer((_) async => authenticated!);
  }

  test(
    'BioAuthUsecase: if divice not supported or bioAuth not available',
    () async {
      stub(isavailble: false);
      final result = await authUseCases.bioAuth.call();
      expect(result.isFailure(), true);
    },
  );

  test('BioAuthUsecase: if available and authenticated,', () async {
    stub(authenticated: true, isavailble: true);
    final result = await authUseCases.bioAuth.call();
    expect(result.isSuccess(), true);
  });

  test('BioAuthUsecase:if available but unauthenticated', () async {
    stub(isavailble: true, authenticated: false);
    final result = await authUseCases.bioAuth.call();
    expect(result.isFailure(), true);
  });
  test('Use Case : Right pin equality Test', () async {
    await authUseCases.createPassPin.call('pass', '5566');
    final result = await authUseCases.checkPin.call('5566');
    expect(result.isSuccess(), true);
  });

  test(
    'Edge Case:Try to save less then or more then 4 digit pin test',
    () async {
      final lessthen = await authUseCases.createPassPin.call('pass', '556');

      expect(lessthen.isFailure(), true);

      final morethen = await authUseCases.createPassPin.call('pass', '55555');
      expect(morethen.isFailure(), true);
    },
  );

  test('Edge Case: wrong pin enter test', () async {
    await authUseCases.createPassPin.call('pass', '5566');
    final result = await authUseCases.checkPin.call('4565');
    expect(result.isFailure(), true);
  });

  test('Use Case: Right password Test', () async {
    await authUseCases.createPassPin.call('pass', '5566');
    final result = await authUseCases.checkPass.call('pass');
    expect(result.isSuccess(), true);
  });
  test('Edge Case : Wrong Password', () async {
    await authUseCases.createPassPin.call('pass', '5566');
    final result = await authUseCases.checkPass.call('prop');
    expect(result.isFailure(), true);
  });
}
