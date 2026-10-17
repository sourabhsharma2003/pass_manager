import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:password_manager/src/core/constants/colors.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/features/entries/domain/entry_domain.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';
import 'package:password_manager/src/features/entries/utils/helper.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/b_field.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/category_dropdown.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/save_button.dart';

class AddEntryBottomSheet extends ConsumerStatefulWidget {
  const AddEntryBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddEntryBottomSheet();
  }
}

class _AddEntryBottomSheet extends ConsumerState<AddEntryBottomSheet> {
  final TextEditingController siteNameController = TextEditingController();
  final TextEditingController userNameorEMail = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final FocusNode _namenode = FocusNode();
  final FocusNode _mailnode = FocusNode();
  final FocusNode _passnode = FocusNode();
  EntryCategory category = EntryCategory.others;
  Widget topline() {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 45,
        child: const Divider(
          thickness: 4,
          radius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  Widget heading(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        name,
        style: TextStyle(fontSize: 12, color: AppColors.primary),
      ),
    );
  }

  Widget bField(
    TextEditingController controller,
    String hinttext,
    String matcher, {
    ValueKey? key,
    GlobalKey? contextKey,
    FocusNode? node,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: SizedBox(
        height: 60,
        key: contextKey,
        child: BFields(
          key: key,
          validator: (v) {
            return Helper.validatorError(matcher, v: v);
          },
          contentPadding: const EdgeInsets.only(bottom: 10, left: 5),
          controller: controller,
          hintext: hinttext,
          focusNode: node,
        ),
      ),
    );
  }

  Widget dropdown() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: CategoryDropdown(
          key: WidgetKeys.dropdowncategory,
          initialSelection: category,
          onSelected: (value) {
            category = value ?? EntryCategory.others;
          },
          dropdownMenuEntries: [
            DropdownMenuEntry(value: EntryCategory.personal, label: 'Personal'),
            DropdownMenuEntry(value: EntryCategory.work, label: 'Work'),
            DropdownMenuEntry(value: EntryCategory.others, label: 'Others'),
          ],
        ),
      ),
    );
  }

  Widget save() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SaveButton(
          key: WidgetKeys.saveEntrybutton,
          onTap: () {
            if (key.currentState!.validate()) {
              ref
                  .read(entryNotifierProvider.notifier)
                  .addNewEntry(
                    EntryDomain(
                      id: '',
                      sitename: siteNameController.text,
                      userNameOrEmail: userNameorEMail.text,
                      password: password.text,
                      entryCategory: category,
                    ),
                  );
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            }
          },
          bgcolor: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Text('Save', style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 200),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topline(),
                heading('Site name'),
                bField(
                  node: _namenode,
                  key: WidgetKeys.entrynamefield,
                  siteNameController,
                  'e.g Instagram',
                  'sitename',
                ),
                heading('Username or email'),
                bField(
                  node: _mailnode,
                  key: WidgetKeys.entryMailorUserfield,
                  userNameorEMail,
                  'gmail@.com',
                  'email',
                ),
                heading('Password'),
                bField(
                  node: _passnode,
                  key: WidgetKeys.entrypassfield,
                  password,
                  'password',
                  'pass',
                ),
                dropdown(),
                save(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
