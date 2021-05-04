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
      color: kBackgroundColor,
      elevation: 4,
      cardChild: Center(
          child: Text(text,
              style: TextStyle(
                fontSize: 18,
                color: kGreenColor,
                fontWeight: FontWeight.bold,
              ))),
      onTap: onTap,
    );
  }
}
