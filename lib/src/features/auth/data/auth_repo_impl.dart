import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/auth/data/biometric_service.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final StorageService service;
  final BiometricService biometricService;
  AuthRepoImpl(this.service, this.biometricService);
  @override
  Future<Result<String>> readPass() async {
    final result = await service.readPass();
    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    return result;
  }

  @override
  Future<Result<String>> readPin() async {
    final result = await service.readPin();
    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    return result;
  }

  @override
  Future<Result<void>> savePassPin(String pass, String pin) async {
    final result = await service.savePassPin(pass, pin);

    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    return result;
  }

  @override
  Future<Result<void>> bioAuth() async {
    final bioauth = await biometricService.bioauthenticate();
    if (bioauth.isFailure()) {
      return Result.failure(bioauth.error);
    }
    return Result.success(true);
  }

  @override
  Future<Result<void>> isBioAuthAvaible() async {
    final bioavailble = await biometricService.isBiometAvailable();
    if (bioavailble.isFailure()) {
      return Result.failure(bioavailble.error);
    }
    return Result.success(null);
  }
}
