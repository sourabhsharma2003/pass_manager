import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manager/src/core/result_wrapper/result.dart';

class StorageService {
  final FlutterSecureStorage storage;
  StorageService(this.storage);

  Future<Result<void>> savePassPin(String pass, String pin) async {
    try {
     await  Future.wait([
        storage.write(key: 'pin', value: pin),

        storage.write(key: 'pass', value: pass)
      ]);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<String>> readPin() async {
    try {
      final savedpin = await storage.read(key: 'pin');
      if (savedpin == null || savedpin.isEmpty) {
        return Result.failure('no pin saved yet');
      }
      return Result.success(savedpin);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  Future<Result<String>> readPass() async {
    try {
      final savedpass = await storage.read(key: 'pass');
      if (savedpass == null || savedpass.isEmpty) {
        return Result.failure('no password saved yet');
      }
      return Result.success(savedpass);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
