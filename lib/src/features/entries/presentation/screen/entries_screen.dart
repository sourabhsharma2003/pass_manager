import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_manager/src/core/constants/app_string.dart';
import 'package:password_manager/src/core/constants/colors.dart';
import 'package:password_manager/src/core/constants/widget_keys.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/error_widget.dart';
import 'package:password_manager/src/features/auth/presentation/widgets/valt_container.dart';
import 'package:password_manager/src/features/entries/presentation/riverpod/providers.dart';
import 'package:password_manager/src/features/entries/presentation/view/add_entry_bottom_sheet.dart';
import 'package:password_manager/src/features/entries/presentation/view/view_switcher.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/save_button.dart';
import 'package:password_manager/src/features/entries/presentation/widgets/searchbar.dart';

class EntriesScreen extends ConsumerStatefulWidget {
  const EntriesScreen({super.key});

  @override
  ConsumerState<EntriesScreen> createState() => _EntriesScreenState();
}

class _EntriesScreenState extends ConsumerState<EntriesScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ref.read(entryNotifierProvider.notifier).getEntries(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget vault() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: VaultContainer(icon: Icons.lock, scale: 30, iconsize: 12),
    );
  }

  Widget apptitle() {
    return Flexible(
      child: Text(
        overflow: TextOverflow.ellipsis,
        AppString.appName,
        style: GoogleFonts.fraunces(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontSize: 15,

          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget searchbar() {
    return CustomSearchbar(
      hintText: 'Search UserNameOrEmail',
      onSearch: () {
        if (controller.text.isEmpty) {
          ref.read(entryNotifierProvider.notifier).getEntries();
          return;
        }
        ref
            .read(entryNotifierProvider.notifier)
            .searchEntries(controller.text.trim());
      },
      textFieldcontroller: controller,
      onremove: () {
        controller.clear();
        ref.read(entryNotifierProvider.notifier).getEntries();
      },
    );
  }

  Widget add() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SaveButton(
        key: WidgetKeys.addEntrybutton,
        bgcolor: AppColors.primary,
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddEntryBottomSheet(),
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Future<void> _errordialog(BuildContext context, String error) {
    return showDialog(
      context: context,
      builder: (context) => ErrorDialog(
        title: 'Login Error',
        content: error,
        onTap: () {
          Navigator.pop(context);
        },
        actionName: 'Retry',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(entryNotifierProvider, (prev, next) {
      if (next.error != null || prev?.error != next.error) {
        _errordialog(context, next.error??'');
      }
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 70),
        child:SafeArea(child:  Row(
          mainAxisAlignment: .spaceBetween,
          mainAxisSize: .max,
          children: [vault(), apptitle(), add()],
        )),
      ),
      body: Center(child: Column(children: [searchbar(), EntryViewSwitcher()])),
    );
  }
}
