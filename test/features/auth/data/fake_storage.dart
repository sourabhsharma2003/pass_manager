import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
    await Future.delayed(const Duration(milliseconds: 200));
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
    await Future.delayed(const Duration(milliseconds: 200));
    _memory[key] = value;
  }
}