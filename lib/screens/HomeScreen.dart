import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/screens/HomeScreenPages/CurrentUserScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ListVehiclesScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ManageCompanyScreen.dart';
import 'package:flutter/material.dart';

const _headerTextStyle = TextStyle(fontSize: 30, color: kWhite80);

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navBarIndex = 1;
  final List<Widget> _screens = [
    ManageCompanyScreen(),
    ListVehiclesScreen(),
    CurrentUserScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Column(
          children: [
            _HeaderWidget(index: navBarIndex),
            _screens[navBarIndex],
          ],
        ),
        bottomNavBar: BottomNavBar(onTap: (int index) {
          navBarIndex = index;
          setState(() {});
        }),
        headerText: 'Welcome'
        // Provider.of<AppData>(context, listen: false).user?.phoneNumber ?? '',
        );
  }
}

class _HeaderWidget extends StatelessWidget {
  final int index;
  final Map<int, String> screenHeaderMap = {
    0: 'Manage Company',
    1: 'Our Vehicles',
    2: 'User Info'
  };

  _HeaderWidget({@required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(screenHeaderMap[index], style: _headerTextStyle));
  }
}
