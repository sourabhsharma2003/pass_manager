import 'package:flutter/foundation.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';

@immutable
class EntryPageState {
  final EntryState entryState;
  final List<EntryDomain>? queryEntries;
  final Map<EntryCategory, List<EntryDomain>>? entries;
  final String? error;

  const EntryPageState({
    this.queryEntries,
    this.entries,
    this.entryState = EntryState.initial,
    this.error,
  });

  EntryPageState copywith({
    final List<EntryDomain>? queryEntries,
    EntryState? entryState,
    Map<EntryCategory, List<EntryDomain>>? entries,
    String? error,
  }) {
    return EntryPageState(
      queryEntries: queryEntries??this.queryEntries,
      entries: entries ?? this.entries,
      entryState: entryState ?? this.entryState,
      error: error ?? this.error,
    );
  }
}

enum EntryState { loading, initial, loaded ,noresult,querLoaded}
