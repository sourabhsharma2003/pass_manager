import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:password_manager/src/features/auth/data/storage_service.dart';

void main() {
  late Fakestorage fakestorage;
  late StorageService storageService;

  setUp(() {
    fakestorage = Fakestorage();
    storageService = StorageService(fakestorage);
  });

  test(' saving pinAndpass test ', () async {
    final result = await storageService.savePassPin('test', '3156');
    expect(result.isSuccess(), true);
  });

  test('Read Pin Test', () async {
    await storageService.savePassPin('pass', '3156');
    final result = await storageService.readPin();
    expect(result.isSuccess(), true);
  });
  test('Read Password Test', () async {
    await storageService.savePassPin('pass', '3156');
    final result = await storageService.readPass();
    expect(result.isSuccess(), true);
  });

  test('change pin & pass test', () async {
   await storageService.savePassPin('pass', '5256');
    final pin = await storageService.readPin();
    final pass = await storageService.readPass();
    expect(pin.data, equals('5256'));
    expect(pass.data, equals('pass'));
  });
}

class Fakestorage extends FlutterSecureStorage {
  final Map<String, dynamic> _memory = {};

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
   
    return _memory[key];
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    
    _memory[key] = value;
  }
}
