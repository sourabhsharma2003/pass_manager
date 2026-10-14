import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/src/features/auth/data/auth_repo_impl.dart';
import 'package:password_manager/src/features/auth/data/biometric_service.dart';
import 'package:password_manager/src/features/auth/data/storage_service.dart';
import 'package:password_manager/src/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:password_manager/src/features/auth/presentation/riverpod/business/auth_notifier.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';

final authSecureStorageprovider = Provider(
  (ref) => StorageService(FlutterSecureStorage()),
);
final authbioServiceProvider = Provider(
  (ref) => BiometricService(LocalAuthentication()),
);
final authRepoProvider = Provider(
  (ref) => AuthRepoImpl(
    ref.watch(authSecureStorageprovider),
    ref.watch(authbioServiceProvider),
    ref.watch(entryDataprovider)
  ),
);

final authUseCasesProvider = Provider(
  (ref) => AuthUseCases(ref.watch(authRepoProvider)),
);

final authNotifierProvider = NotifierProvider(() => AuthNotifier());

