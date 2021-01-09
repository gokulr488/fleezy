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
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
            elevation: 5.0,
            color: colour,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
                onPressed: onPressed,
                minWidth: width,
                height: 42.0,
                child: Text(title,
                    style: TextStyle(color: Colors.white, fontSize: 16)))));
  }
}
