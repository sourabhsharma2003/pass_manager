import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final StorageService service;
  AuthRepoImpl(this.service);
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
  Future<Result<void>> savePass(String pass) async {
    final result = await service.savePass(pass);
    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    return result;
  }

  @override
  Future<Result<void>> savePin(String pin) async{
    final result = await service.savePin(pin);
    if (result.isFailure()) {
      return Result.failure(result.error);
    }
    return result;
  }
}
