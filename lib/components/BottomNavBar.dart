import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  static const Color kThemeColour = Colors.blue;
  static const Color kBackGroundColour = Color(0xff212121);
  final Function onTap;

  const BottomNavBar({this.onTap});
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: kThemeColour,
      backgroundColor: kBackGroundColour,
      buttonBackgroundColor: kThemeColour,
      animationDuration: Duration(milliseconds: 300),
      height: 50,
      index: 2,
      items: [
        Icon(
          Icons.location_pin,
          size: 20,
          color: kBackGroundColour,
        ),
        Icon(
          Icons.shopping_cart,
          size: 20,
          color: kBackGroundColour,
        ),
        Icon(
          Icons.home_rounded,
          size: 20,
          color: kBackGroundColour,
        ),
        Icon(
          Icons.list,
          size: 20,
          color: kBackGroundColour,
        ),
        Icon(
          Icons.logout,
          size: 20,
          color: kBackGroundColour,
        )
      ],
      onTap: onTap,
    );
  }
}
