import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({this.onTap, this.cardChild, this.color, this.elevation});
  final Function onTap;
  final Widget cardChild;
  final Color color;
  final double elevation;

  @override
  InkWell build(BuildContext context) {
    return InkWell(
      splashColor: Colors.yellow[400],
      onTap: () => onTap(),
      child: Card(
        color: color ?? kCardOverlay[elevation] ?? kCardOverlay[4],
        elevation: elevation ?? 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: cardChild,
        ),
      ),
    );
  }
}
