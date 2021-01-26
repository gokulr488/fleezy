import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/screens/CurrentUserScreen.dart';
import 'package:fleezy/screens/ListVehiclesScreen.dart';
import 'package:fleezy/screens/ManageCompanyScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _kOurVehiclesTextStyle =
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
    return BaseScreen(child: Consumer<AppData>(builder: (context, appData, _) {
      return Column(
        children: [
          _HeaderWidget(userName: appData.user?.phoneNumber ?? ''),
          _screens[appData.bottomNavBarIndex],
        ],
      );
    }), bottomNavBar: BottomNavBar(onTap: (index) {
      Provider.of<AppData>(context, listen: false).setBottomNavBarIndex(index);
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
        Text('Our Vehicles', style: _kOurVehiclesTextStyle),
        SizedBox(height: 10),
      ],
    );
  }
}
