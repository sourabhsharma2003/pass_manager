import 'package:flutter/material.dart';


class EntryCard extends StatelessWidget {
  final String title;
  final String subtitle;
 
  final Widget leadingWidget;
  final Widget? trailing;
  const EntryCard({
    super.key,
    this.trailing,
    required this.leadingWidget,
    required this.title,
    required this.subtitle,

  });

 



  Widget customTitle(String name, double size) {
    return Text(
      name,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: size),
    );
  }



  Widget listTileContent() {
    return ListTile(
      visualDensity: VisualDensity.compact,
      contentPadding: const EdgeInsets.only(left: 4, top: 1, bottom: 1),
      title: customTitle(title, 13),
      subtitle: customTitle(subtitle, 11),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 200;

    return Card(
      
      clipBehavior: Clip.antiAlias,

      child: isNarrow
          ? Column(mainAxisAlignment: .spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 0),
                  child: leadingWidget,
                ),
                listTileContent(),
                trailing??const SizedBox.shrink(),
              ],
            )
          : Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: leadingWidget,
                ),
                Expanded(child: listTileContent()),
                trailing??const SizedBox.shrink(),
              ],
            ),
    );
  }
}
