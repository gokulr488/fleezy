import 'package:flutter/material.dart';

class GridLayout extends StatelessWidget {
  final List<Widget> children;

  const GridLayout({this.children});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: children),
    );
  }
}
