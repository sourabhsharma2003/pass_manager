import 'package:flutter/material.dart';

import 'package:password_manager/src/features/entries/domain/entry_domain.dart';
import 'package:password_manager/src/features/entries/presentation/container/entry_actions_container.dart';

import 'package:password_manager/src/features/entries/presentation/widgets/alphabet_random_profile_widget.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/entry_card.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/grouped_builder.dart';

class CategorizeEntriesView extends StatelessWidget {
  final Map<EntryCategory, List<EntryDomain>> entries;
  const CategorizeEntriesView({super.key,required this.entries});

  @override
  Widget build(BuildContext context,) {
    
    return Expanded(
      child: GroupedBuilder<EntryCategory, EntryDomain>(
        data: entries,
        groupbuilder: (group) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(group.name.toUpperCase(), style: TextStyle(fontSize: 12)),
        ),
        itembuilder: (item) => EntryCard(
          key: ValueKey(item.id),
          leadingWidget: AlphabetRandomProfileWidget(name: item.sitename),
          title: item.sitename,
          subtitle: item.userNameOrEmail,
          trailing: EntryActionsContainer( id: item.id, password: item.password),
        ),
      ),
    );
  }
}
