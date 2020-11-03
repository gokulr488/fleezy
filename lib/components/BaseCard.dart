import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Function onTap;
  final Widget cardChild;
  final Color color;
  final double elevation;

  BaseCard({this.onTap, this.cardChild, this.color, this.elevation});
  @override
  InkWell build(BuildContext context) {
    return InkWell(
      splashColor: Colors.teal,
      onTap: onTap,
      child: Card(
        child: Center(
          child: cardChild,
        ),
        color: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
