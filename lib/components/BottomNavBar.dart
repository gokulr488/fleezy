import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

const TextStyle _kIconTextTS = TextStyle(fontSize: 16);

class BottomNavBar extends StatelessWidget {
  static const Color kThemeColour = kHighlightColour;
  final Function onTap;
  final int selectedIndex;

  const BottomNavBar({this.onTap, this.selectedIndex});
  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: selectedIndex,
      showElevation: true,
      onItemSelected: onTap,
      backgroundColor: kBackgroundColor,
      iconSize: 30,
      animationDuration: kAnimDuraction,
      curve: kAnimCurve,
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.account_balance_outlined),
            title: Text('Company', style: _kIconTextTS),
            activeColor: kHighlightColour,
            inactiveColor: Color(0xFFd84315)),
        BottomNavyBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text('Home', style: _kIconTextTS),
            activeColor: kHighlightColour,
            inactiveColor: Color(0xFFd84315)),
        BottomNavyBarItem(
            icon: Icon(Icons.account_circle_outlined),
            title: Text('User Info', style: _kIconTextTS),
            activeColor: kHighlightColour,
            inactiveColor: Color(0xFFd84315)),
      ],
    );
  }
}
