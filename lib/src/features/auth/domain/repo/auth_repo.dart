import 'package:password_manager/src/core/result_wrapper/result.dart';

abstract class AuthRepo {
  Future<Result<String>> readPass();

  Future<Result<String>> readPin();

  Future<Result<void>> savePass(String pass);

  Future<Result<void>> savePin(String pin);
}
