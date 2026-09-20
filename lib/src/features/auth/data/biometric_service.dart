import 'package:local_auth/local_auth.dart';
import 'package:password_manager/src/core/result_wrapper/result.dart';

class BiometricService {
  final LocalAuthentication auth;
  BiometricService(this.auth);

  Future<Result<void>> isBiometAvailable() async {
    try {
      final bool canauthenticate = await auth.canCheckBiometrics;
      final bool devicesuppoted = await auth.isDeviceSupported();

      if (canauthenticate && devicesuppoted) {
        return Result.success(null);
      }
      return Result.failure('device not supported');
    } catch (e) {
      return Result.failure('device not supported');
    }
  }

  Future<Result<void>> bioauthenticate() async {
    try {
      final result = await auth.authenticate(
        localizedReason: 'Authentication to unlock your vault',
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
      if (result) {
        return Result.success(null);
      }
      return Result.failure('failed');
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
