import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class DataRowWidget extends StatelessWidget {
  final String field;
  final String value;
  final Color color;

  const DataRowWidget({@required this.field, @required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(field, style: TextStyle(fontSize: 18, color: color ?? kWhite80)),
        Text(value, style: TextStyle(fontSize: 18, color: color ?? kWhite80)),
      ],
    );
  }
}
