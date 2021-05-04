import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class HorLine extends StatelessWidget {
  const HorLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: kWhite25,
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }
}
