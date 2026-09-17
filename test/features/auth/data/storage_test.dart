
import 'package:flutter_test/flutter_test.dart';

import 'package:password_manager/src/features/auth/data/storage_service.dart';

import 'fake_storage.dart';

void main() {
  final fakestorage = Fakestorage();

  final storageService = StorageService(fakestorage);
  test(' saving pin test ', () async {
    final result = await storageService.savePin('3156');
    expect(result.isSuccess(), true);
  });
  test('Save pass test', () async {
    final result = await storageService.savePass('test@');
    expect(result.isSuccess(), true);
  });

  test('Read Pin Test', () async {
    final result = await storageService.readPin();
    expect(result.isSuccess(), true);
  });
  test('Read Password Test', () async {
    final result = await storageService.readPass();
    expect(result.isSuccess(), true);
  });

  test('EdgeCase Test: change pin & pass test', () async {
    await Future.wait([
      storageService.savePin('5256'),
      storageService.savePass('pass'),
    ]);
    final pin = await storageService.readPin();
    final pass = await storageService.readPass();
    expect(pin.data, equals('5256'));
    expect(pass.data, equals('pass'));
  });
}


