import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/screens/HomeScreenPages/CurrentUserScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ListVehiclesScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ManageCompanyScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _headerTextStyle =
    TextStyle(fontSize: 30, fontFamily: 'FundamentoRegular');

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';
  final List<Widget> _screens = [
    ManageCompanyScreen(),
    ListVehiclesScreen(),
    CurrentUserScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Consumer<UiState>(builder: (context, uiState, _) {
          return Column(
            children: [
              _HeaderWidget(),
              _screens[uiState.bottomNavBarIndex],
            ],
          );
        }),
        bottomNavBar: BottomNavBar(onTap: (index) {
          Provider.of<UiState>(context, listen: false)
              .setBottomNavBarIndex(index);
        }),
        headerText: 'Welcome'
        // Provider.of<AppData>(context, listen: false).user?.phoneNumber ?? '',
        );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<UiState>(builder: (context, uiState, _) {
        return Text(uiState.screenHeaderMap[uiState.bottomNavBarIndex],
            style: _headerTextStyle);
      }),
    );
  }
}
