import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class DataRowWidget extends StatelessWidget {
  final String field;
  final String value;
  final Color color;
  final double fontSize;

  const DataRowWidget(
      {@required this.field, @required this.value, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(field,
              style: TextStyle(
                  fontSize: fontSize ?? 18,
                  color: kTextColor,
                  fontWeight: FontWeight.bold)),
          Text(value,
              style: TextStyle(
                  fontSize: fontSize ?? 18,
                  color: color ?? kTextColor,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
