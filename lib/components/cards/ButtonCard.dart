import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final String buttonText;
  final Function onTap;

  const ButtonCard({this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    const TextStyle kButtonTextStyle =
        TextStyle(fontSize: 30, fontFamily: 'FundamentoRegular');
    return BaseCard(
      color: kHighlightColour,
      elevation: 4,
      onTap: onTap,
      cardChild: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            buttonText,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
