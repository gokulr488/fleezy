import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/screens/HomeScreenPages/CurrentUserScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ListVehiclesScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ManageCompanyScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int navBarIndex = 1;
  final List<Widget> _screens = [
    ManageCompanyScreen(),
    ListVehiclesScreen(),
    CurrentUserScreen()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      bottomNavBar: BottomNavBar(
        onTap: (int index) {
          navBarIndex = index;
          _pageController.animateToPage(index,
              duration: kAnimDuraction, curve: kAnimCurve);
          setState(() {});
        },
        selectedIndex: navBarIndex,
      ),
      headerText: 'Welcome',
      //Provider.of<AppData>(context, listen: false).user?.fullName ?? '',
      child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            navBarIndex = index;
            setState(() {});
          },
          children: _screens),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
