
import 'package:flutter/material.dart';

class CustomSearchbar extends StatelessWidget {
  final void Function() onSearch;
  final TextEditingController textFieldcontroller;
  final void Function() onremove;
  final String? hintText;

  const CustomSearchbar({
    super.key,

    required this.onSearch,
    required this.textFieldcontroller,
    this.hintText,

    required this.onremove,
  });

  Widget searchIcon() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: IconButton(onPressed: onSearch, icon: const Icon(Icons.search)),
    );
  }

  Widget textfield() {
    return Expanded(
      child: TextField(
        controller: textFieldcontroller,
        onSubmitted: (value) => onSearch(),
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget removebutton() {
    return ValueListenableBuilder(
      valueListenable:textFieldcontroller,
      builder: (context,value, child) {
        if (value.text.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              onPressed: onremove,
              icon: const Icon(Icons.close),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(16)),
          color: Colors.grey.withValues(alpha: 0.2),
        ),
        child: Row(children: [searchIcon(), textfield(), removebutton()]),
      ),
    );
  }
}
