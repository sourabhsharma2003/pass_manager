import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/copy_widget.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/popup_delete_button.dart';

class EntryActionsContainer extends ConsumerStatefulWidget {
  final String id;
  final String password;
  final ValueKey? popupkey;
  const EntryActionsContainer({
    super.key,
    required this.id,
    required this.password,
    this.popupkey
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EntryActionsContainer();
  }
}

class _EntryActionsContainer extends ConsumerState<EntryActionsContainer> {
  bool obscure = true;
  Widget passwordw() {
    return   Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: SizedBox(
        width: 120,
      
        child: SingleChildScrollView(
          scrollDirection: .horizontal,
          child: Text(
            obscure ? '**********' : widget.password,
            textAlign: .end,
            maxLines: 1,
            style: TextStyle(fontSize: 11),
          ),
        ),
      ),
    );
  }

  Widget eyewidget() {
    return IconButton(
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      onPressed: () {
        setState(() {
          obscure = !obscure;
        });
      },
      icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, size: 15),
    );
  }

  @override
  Widget build(BuildContext context, ) {
    return Stack(
      alignment: .centerRight,
      children: [ passwordw(), Row(mainAxisAlignment: .spaceBetween,
      mainAxisSize: .max,
      children: [
        eyewidget(),
        CopyWidget(text:widget.password),
        PopupDeleteButton(key: widget.popupkey,
          onDelete: () {
            ref.read(entryNotifierProvider.notifier).deleteEntry(widget.id);
          },
        ),
      ],
    )]);
  }
}
/// Action controls for the [Entries] card.
/// 
/// Kept localized within this component rather than the parent view
/// to keep the parent codebase clean and concise.