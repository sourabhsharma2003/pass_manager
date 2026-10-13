import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';
import 'package:password_manager/src/features/entries/domain/entry_use_cases.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/entry_state.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';

class EntryNotifier extends Notifier<EntryPageState> {
  late EntryUseCases useCases;
  @override
  build() {
    useCases = ref.watch(entryUsecasesProvider);

    return EntryPageState();
  }

  Future<void> searchEntries(String query) async {
    if (query.isEmpty) return;
    state = state.copywith(entryState: EntryState.loading);
    final result = await useCases.searchEntry(query);
    if (result.isFailure()) {
      state = state.copywith(error: result.error);
      return;
    }
    if (result.data == null || result.data!.isEmpty) {
      state = state.copywith(entryState: EntryState.noresult);
     
      return;
    }
    state = state.copywith(
      queryEntries: result.data,
      entryState: EntryState.querLoaded,
    );
  }

  Future<void> getEntries() async {
    state = state.copywith(entryState: EntryState.loading);

    final result = await useCases.getEntries();
    if (result.isFailure()) {
      state = state.copywith(error: result.error);
      return;
    }
    if (result.data == null || result.data!.isEmpty) {
      state = state.copywith(entryState: EntryState.initial);
      return;
    }

    state = state.copywith(entries: result.data, entryState: EntryState.loaded);
  }

  Future<void> addNewEntry(EntryDomain entry) async {
    if (entry.password.isEmpty ||
        entry.sitename.isEmpty ||
        entry.userNameOrEmail.isEmpty) {
      return;
    }
    state = state.copywith(entryState: EntryState.loading);
    final result = await useCases.addNewEntry.call(entry);
    if (result.isFailure()) {
      state = state.copywith(error: result.error);
      return;
    }
    final refreshed = await useCases.getEntries();
    state = state.copywith(
      entries: refreshed.data,
      entryState: EntryState.loaded,
    );
  }

  Future<void> deleteEntry(String id) async {
    final delete = await useCases.deleteEntry.call(id);
    if (delete.isFailure()) {
      state = state.copywith(error: delete.error);
      return;
    }
    final getentry = await useCases.getEntries();
    if (getentry.data == null || getentry.data!.isEmpty) {
      reset();
      return;
    }
    state = state.copywith(entries: getentry.data);
  }

  void reset() {
    state = EntryPageState();
  }
}
