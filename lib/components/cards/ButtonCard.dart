import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  static final TextStyle kButtonTextStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: kHighlightColour);
  final String text;
  final Function onTap;
  final Widget child;
  final double height;
  final IconData icon;

  const ButtonCard({this.text, this.onTap, this.child, this.height, this.icon});

  @override
  Widget build(BuildContext context) {
    final children = _buildWidgets();

    return BaseCard(
      elevation: 3,
      onTap: onTap,
      cardChild: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      )),
    );
  }

  List<Widget> _buildWidgets() {
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(
        icon,
        size: 60,
        color: kHighlightColour,
      ));
    }
    if (text != null && text != '') {
      children.add(Text(text, style: kButtonTextStyle));
    }

    return children;
  }
}
