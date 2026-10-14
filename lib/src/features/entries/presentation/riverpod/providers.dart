import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/entries/data/entry_datasorce.dart';
import 'package:password_manager/src/features/entries/data/entry_repo_impl.dart';
import 'package:password_manager/src/features/entries/domain/entry_repo.dart';
import 'package:password_manager/src/features/entries/domain/entry_use_cases.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/entry_notifier.dart';
import 'package:uuid/uuid.dart';

final entryDataprovider = Provider<EntryDatasorce>((ref) => EntryDatasorce());
final uUidProvider = Provider((_) => Uuid());
final entryRepoProvider = Provider<EntryRepo>(
  (ref) => EntryRepoImpl(
    data: ref.watch(entryDataprovider),
    uuid: ref.watch(uUidProvider),
  ),
);
final entryUsecasesProvider = Provider<EntryUseCases>((ref) {
  return EntryUseCases(ref.watch(entryRepoProvider));
});
final entryNotifierProvider = NotifierProvider(() => EntryNotifier());
