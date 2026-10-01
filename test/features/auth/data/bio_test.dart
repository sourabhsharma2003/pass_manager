import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password_manager/src/features/auth/data/biometric_service.dart';

void main() {
  late FakeLocalAuth fakeLocalAuth;
  late BiometricService biometricService;

  setUp(() {
    fakeLocalAuth = FakeLocalAuth();
    biometricService = BiometricService(fakeLocalAuth);
  });

  void stub(bool isavailble) {
    when(
      () => fakeLocalAuth.canCheckBiometrics,
    ).thenAnswer((_) async => isavailble);
    when(
      () => fakeLocalAuth.isDeviceSupported(),
    ).thenAnswer((_) async => isavailble);
  }

  
  test('BioAuthService: test BioAuth not Available ', () async {
    stub(false);

    final bioservice = await biometricService.isBiometAvailable();

    expect(bioservice.isFailure(), true);
  });

  test('BioAuthService:test BioAuth Available', () async {
    stub(true);
    final bioservice = await biometricService.isBiometAvailable();

    expect(bioservice.isSuccess(), true);
  });
}

class FakeLocalAuth extends Mock implements LocalAuthentication {}
