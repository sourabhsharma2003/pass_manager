import 'package:password_manager/src/core/result_wrapper/result.dart';

abstract class AuthRepo {
  Future<Result<String>> readPass();

  Future<Result<String>> readPin();

  Future<Result<void>> savePassPin(String pass, String pin);
  Future<Result<void>> isBioAuthAvaible();

  Future<Result<void>> bioAuth();
}
