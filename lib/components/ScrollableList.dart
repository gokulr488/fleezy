import 'package:flutter/material.dart';

class ScrollableList extends StatelessWidget {
  final List<Widget> items;
  final double childrenHeight;
  final ScrollController scrollController;
  ScrollableList(
      {this.items, @required this.childrenHeight, this.scrollController});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //padding: const EdgeInsets.all(8),
      itemCount: items.length,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: childrenHeight,
          child: items[index],
        );
      },
    );
  }
}
