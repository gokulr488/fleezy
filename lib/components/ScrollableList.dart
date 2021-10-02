import 'package:flutter/material.dart';

class ScrollableList extends StatelessWidget {
  const ScrollableList(
      {this.items, @required this.childrenHeight, this.scrollController});
  final List<Widget> items;
  final double childrenHeight;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //padding: const EdgeInsets.all(8),
      itemCount: items.length,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: childrenHeight,
          child: items[index],
        );
      },
    );
  }
}
