import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/auth/domain/repo/auth_repo.dart';

class AuthUseCases {
  final Savepin savepin;
  final SavePass savePass;
  final CheckPass checkPass;
  final CheckPin checkPin;
  AuthUseCases(AuthRepo repo)
    : savepin = Savepin(repo),
      savePass = SavePass(repo),
      checkPass = CheckPass(repo),
      checkPin = CheckPin(repo);
}

class Savepin {
  final AuthRepo repo;
  Savepin(this.repo);
  Future<Result<void>> call(String pin) async {
    return await repo.savePin(pin);
  }
}

class SavePass {
  final AuthRepo repo;
  SavePass(this.repo);
  Future<Result<void>> call(String pass) async {
    return await repo.savePass(pass);
  }
}

class CheckPin {
  final AuthRepo repo;
  CheckPin(this.repo);
  Future<Result<void>> call(String pin) async {
    final savedpin = await repo.readPin();
    if (savedpin.isFailure()) {
      return Result.failure(savedpin.error);
    }
    if (savedpin.data == pin) {
      return Result.success(null);
    }
    return Result.failure('Wrong pin');
  }
}

class CheckPass {
  final AuthRepo repo;
  CheckPass(this.repo);
  Future<Result<void>> call(String pass) async {
    final savedPass = await repo.readPass();
    if (savedPass.isFailure()) {
      return Result.failure(savedPass.error);
    }
    if (savedPass.data == pass) {
      return Result.success(null);
    }
    return Result.failure('Wrong password');
  }
}
