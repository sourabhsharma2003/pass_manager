import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';
import 'package:password_manager/src/features/entries/presentation/container/entries_card_actions_container.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/alphabet_random_profile_widget.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/entry_card.dart';

class QueryEntries extends ConsumerWidget {
  final List<EntryDomain> queryentries;
  const QueryEntries({super.key, required this.queryentries});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 500,
          mainAxisExtent: width < 200 ? 180 : 90,
        ),
        itemCount: queryentries.length,
        itemBuilder: (context, index) {
          final entry = queryentries[index];
          return EntryCard(
            leadingWidget: AlphabetRandomProfileWidget(name: entry.userNameOrEmail),
            title: entry.sitename,
            subtitle: entry.userNameOrEmail,
            trailing:EntryActionsContainer(id: entry.id, password: entry.password) ,
          );
        },
      ),
    );
  }
}
