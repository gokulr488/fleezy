import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/screens/CurrentUserScreen.dart';
import 'package:fleezy/screens/ListVehiclesScreen.dart';
import 'package:fleezy/screens/ManageCompanyScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _headerTextStyle =
    TextStyle(fontSize: 30, fontFamily: 'FundamentoRegular');
const _kFleezyTextStyle = TextStyle(
    fontSize: 45,
    fontFamily: 'DancingScript',
    fontWeight: FontWeight.bold,
    color: kHighlightColour);

class HomeScreen extends StatelessWidget {
  static const String id = 'HomeScreen';
  final List<Widget> _screens = [
    ManageCompanyScreen(),
    ListVehiclesScreen(),
    CurrentUserScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BaseScreen(child: Consumer<UiState>(builder: (context, uiState, _) {
      return Column(
        children: [
          _HeaderWidget(
              userName: Provider.of<AppData>(context, listen: false)
                      .user
                      ?.phoneNumber ??
                  ''),
          _screens[uiState.bottomNavBarIndex],
        ],
      );
    }), bottomNavBar: BottomNavBar(onTap: (index) {
      Provider.of<UiState>(context, listen: false).setBottomNavBarIndex(index);
    }));
  }
}

class _HeaderWidget extends StatelessWidget {
  final String userName;
  final String screenName;

  const _HeaderWidget({this.userName, this.screenName});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Hi $userName', style: kWelcomeUserTextStyle),
              Text('Fleezy', style: _kFleezyTextStyle)
            ]),
        SizedBox(height: 10),
        Consumer<UiState>(builder: (context, uiState, _) {
          return Text(uiState.screenHeaderMap[uiState.bottomNavBarIndex],
              style: _headerTextStyle);
        }),
        SizedBox(height: 10),
      ],
    );
  }
}
