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
      cardChild: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: TextStyle(
                  fontSize: 20,
                  color: kHighlightColour,
                  fontWeight: FontWeight.bold,
                )),
            Icon(Icons.date_range, color: kHighlightColour, size: 30)
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
