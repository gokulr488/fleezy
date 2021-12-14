import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({this.child, this.bottomNavBar, @required this.headerText});
  final Widget child;
  final Widget bottomNavBar;
  final String headerText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerText.isEmpty
          ? null
          : AppBar(
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(headerText,
                        style: GoogleFonts.laila(
                          color: kTextColor,
                          fontSize: 21,
                        )),
                    Text('Fleezy',
                        style: GoogleFonts.dancingScript(
                            color: kHighlightColour,
                            shadows: shadow,
                            fontWeight: FontWeight.bold,
                            fontSize: 45))
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
