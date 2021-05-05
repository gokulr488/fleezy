import 'package:fleezy/Common/UiConstants.dart';
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
      splashColor: Colors.yellow[400],
      onTap: onTap,
      child: Card(
        child: Center(
          child: cardChild,
        ),
        color: color ?? kCardOverlay[elevation] ?? kCardOverlay[4],
        elevation: elevation ?? 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
