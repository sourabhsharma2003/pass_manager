import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/auth/data/biometric_service.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/domain/repo/auth_repo.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';

class AuthRepoImpl implements AuthRepo {
  final StorageService service;
  final BiometricService biometricService;
  final EntryDatasorce database;
  const AuthRepoImpl(this.service, this.biometricService, this.database);
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
    return Result.success(null);
  }

  @override
  Future<Result<void>> isBioAuthAvaible() async {
    final bioavailble = await biometricService.isBiometAvailable();
    if (bioavailble.isFailure()) {
      return Result.failure(bioavailble.error);
    }
    return Result.success(null);
  }

  @override
  Future<Result<void>> forgot(String pin, String pass) async {
    final result = await service.savePassPin(pass, pin);
    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    final db = await database.deleteDatabase();
    if (db.isFailure()) {
      return Result.failure(db.error);
    }
    return Result.success(null);
  }
}
