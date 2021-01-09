import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  static const Color kThemeColour = kHighlightColour;
  final Function onTap;

  const BottomNavBar({this.onTap});
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: kThemeColour,
      backgroundColor: kBackgroundColor,
      buttonBackgroundColor: kThemeColour,
      animationDuration: Duration(milliseconds: 300),
      height: 50,
      index: 1,
      items: [
        Icon(
          Icons.location_pin,
          size: 20,
          color: kBackgroundColor,
        ),
        Icon(
          Icons.home,
          size: 20,
          color: kBackgroundColor,
        ),
        Icon(
          Icons.account_circle,
          size: 20,
          color: kBackgroundColor,
        )
      ],
      onTap: onTap,
    );
  }
}
