import 'package:flutter_test/flutter_test.dart';
import 'package:password_manager/src/features/auth/data/auth_repo_impl.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/domain/use_cases/auth_use_cases.dart';

import '../data/fake_storage.dart';

void main() {
  final fakeStorage = Fakestorage();
  final repo = AuthRepoImpl(StorageService(fakeStorage));

  test('Use Case : Right pin equality Test', () async {
    await Savepin(repo).call('5566');
    final result = await CheckPin(repo).call('5566');
    expect(result.isSuccess(), true);
  });

  test('Edge Case: wrong pin enter test', () async {
    final result = await CheckPin(repo).call('4565');
    expect(result.isFailure(), true);
  });

  test('Use Case: Right password Test', () async {
    await SavePass(repo).call('pass');
    final result = await CheckPass(repo).call('pass');
    expect(result.isSuccess(), true);
  });
  test('Edge Case : Wrong Password', () async {
    final result = await CheckPass(repo).call('prop');
    expect(result.isFailure(), true);
  });
}
