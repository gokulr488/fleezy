import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final String buttonText;
  final Function onTap;
  final Widget child;
  final double height;

  const ButtonCard({this.buttonText, this.onTap, this.child, this.height});

  @override
  Widget build(BuildContext context) {
    const TextStyle kButtonTextStyle =
        TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    return BaseCard(
      color: kHighlightColour,
      elevation: 4,
      onTap: onTap,
      cardChild: SizedBox(
        height: height ?? 50,
        child: Center(
          child: child ??
              Text(
                buttonText,
                style: kButtonTextStyle,
              ),
        ),
      ),
    );
  }
}
