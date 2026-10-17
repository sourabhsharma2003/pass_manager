import 'package:flutter/material.dart';
import 'package:password_manager/src/core/constants/colors.dart';

class CategoryDropdown<T> extends StatelessWidget {
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final T? initialSelection;
  final void Function(T?)? onSelected;
  const CategoryDropdown({super.key,required this.dropdownMenuEntries,required this.initialSelection,required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
    
      onSelected:onSelected ,
      initialSelection: initialSelection,
      selectOnly: true,
      hintText: 'Select Category',
      alignmentOffset: Offset(5, 5),
      menuStyle: MenuStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      textStyle: TextStyle(fontSize: 12),
      trailingIcon: const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Icon(Icons.arrow_drop_down, size: 20),
      ),
      width: 170,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 10),
        constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        outlineBorder: BorderSide(color: AppColors.blue, width: 0.6),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.blue, width: 0.6),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      dropdownMenuEntries: dropdownMenuEntries
    );
  }
}
