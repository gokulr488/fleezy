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
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
            onPressed: onPressed,
            minWidth: width ?? MediaQuery.of(context).size.width * 0.75,
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))));
  }
}
