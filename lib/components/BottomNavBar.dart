import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:flutter/material.dart';

const TextStyle _kIconTextTS = TextStyle(fontSize: 16);

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({this.onTap, this.selectedIndex});
  static const Color kThemeColour = kHighlightColour;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: selectedIndex,
      onItemSelected: (int index) => onTap(index),
      backgroundColor: kBackgroundColor,
      iconSize: 30,
      animationDuration: kAnimDuraction,
      curve: kAnimCurve,
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: const Icon(Icons.account_balance_outlined),
            title: const Text('Company', style: _kIconTextTS),
            activeColor: kHighlightColour,
            inactiveColor: const Color(0xFFd84315)),
        BottomNavyBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text('Home', style: _kIconTextTS),
            activeColor: kHighlightColour,
            inactiveColor: const Color(0xFFd84315)),
        BottomNavyBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            title: const Text('User Info', style: _kIconTextTS),
            activeColor: kHighlightColour,
            inactiveColor: const Color(0xFFd84315)),
      ],
    );
  }
}
