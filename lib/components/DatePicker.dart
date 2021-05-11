import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final Function onTap;
  final String text;

  const DatePicker({this.onTap, this.text});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: SizedBox(
        height: 40,
        child: Center(
          child: Text(text,
              style: TextStyle(
                fontSize: 20,
                color: kHighlightColour,
              )),
        ),
      ),
      onTap: onTap,
    );
  }
}
