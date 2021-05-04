import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

const _kFleezyTextStyle = TextStyle(
    fontSize: 45,
    fontFamily: 'DancingScript',
    fontWeight: FontWeight.bold,
    color: kHighlightColour);
const _kWelcomeUserTextStyle =
    TextStyle(fontSize: 22, fontFamily: 'FundamentoRegular', color: kWhite80);

class BaseScreen extends StatelessWidget {
  final Widget child;
  final Widget bottomNavBar;
  final String headerText;
  BaseScreen({this.child, this.bottomNavBar, @required this.headerText});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerText.isEmpty
          ? null
          : AppBar(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(headerText, style: _kWelcomeUserTextStyle),
                    Text('Fleezy', style: _kFleezyTextStyle)
                  ]),
            ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: child,
        ),
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
