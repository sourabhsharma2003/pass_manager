
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/core/widgets/loading_indicator.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/entry_states.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';
import 'package:password_manager/src/features/entries/presentation/view/categorized_entries_view.dart';
import 'package:password_manager/src/features/entries/presentation/view/empty_view.dart';
import 'package:password_manager/src/features/entries/presentation/view/query_entries.dart';

class EntryViewSwitcher extends ConsumerWidget {
  const EntryViewSwitcher({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final states = ref.watch(entryNotifierProvider);

    return switch (states.entryState) {
      EntryState.initial => EmptyView(key: WidgetKeys.entryEmptyWidget, text: 'No Entries Yet'),
      EntryState.loaded => CategorizeEntriesView(key: WidgetKeys.entryCategoryWidget, entries: states.entries??{}),
      EntryState.loading => LoadingIndicator(),
      EntryState.noresult=>Text('No entries found'),
      EntryState.querLoaded=>QueryEntries(queryentries: states.queryEntries??[])
    };
  }
}
