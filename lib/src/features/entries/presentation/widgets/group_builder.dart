import 'package:flutter/material.dart';

class GroupBuilder<K, T> extends StatelessWidget {
  final Map<K, List<T>> data;
  final Widget Function(K) groupbuilder;
  final Widget? Function(T) itembuilder;
  const GroupBuilder({
    super.key,
    required this.data,
    required this.itembuilder,
    required this.groupbuilder
  });
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.entries.map((value) {
        final item = value.value;
        return Column(
         crossAxisAlignment: .start,
          children: [
            groupbuilder(value.key),
            GridView.builder(
              
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
                mainAxisExtent: MediaQuery.of(context).size.width<200?200:90
              ),
              itemCount: item.length,
              itemBuilder: (context, index) => itembuilder(item[index]),
            ),
          ],
        );
      }).toList(),
    );
  }
}
