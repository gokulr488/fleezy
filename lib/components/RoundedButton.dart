import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.title, this.colour, @required this.onPressed, this.width});

  final Color colour;
  final String title;
  final double width;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5.0,
        color: colour ?? kHighlightColour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
            onPressed: onPressed,
            minWidth: width ?? MediaQuery.of(context).size.width * 0.75,
            child: Text(title, style: TextStyle(fontSize: 16))));
  }
}
