import 'package:password_manager/src/core/result_wrapper/result.dart';
import 'package:password_manager/src/features/auth/domain/repo/auth_repo.dart';

class AuthUseCases {
  final SavePassPin savePassPin;
  final CheckPass checkPass;
  final CheckPin checkPin;
  final BioAuth bioAuth;
  final VeriFy veriFy;
  AuthUseCases(AuthRepo repo)
    : savePassPin = SavePassPin(repo),
      checkPass = CheckPass(repo),
      checkPin = CheckPin(repo),
      bioAuth = BioAuth(repo),
      veriFy = VeriFy(repo);
}

class VeriFy {
  final AuthRepo repo;
  VeriFy(this.repo);
  Future<Result<void>> call() async {
    final ispinexist = await repo.readPin();
    if (ispinexist.isFailure()) {
      return Result.failure(ispinexist.error);
    }
    return Result.success(null);
  }
}

class SavePassPin {
  final AuthRepo repo;
  SavePassPin(this.repo);
  Future<Result<void>> call(String pass, String pin) async {
    if (pin.length > 4 || pin.length < 4) {
      return Result.failure('pin should be 4 digits');
    }
    return await repo.savePassPin(pass, pin);
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
    return Result.failure('Wrong pin or pin Not Set yet');
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
    return Result.failure('Wrong password or Not Set yet');
  }
}

class BioAuth {
  final AuthRepo repo;
  BioAuth(this.repo);
  Future<Result<void>> call() async {
    final isbioAvailable = await repo.isBioAuthAvaible();
    if (isbioAvailable.isFailure()) {
      return Result.failure(isbioAvailable.error);
    }
    final bioAuth = await repo.bioAuth();
    if (bioAuth.isFailure()) {
      return Result.failure(bioAuth.error);
    }
    return Result.success(null);
  }
}
