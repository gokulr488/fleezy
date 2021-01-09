
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/BottomNavBar.dart';
import 'package:fleezy/screens/CurrentUserScreen.dart';
import 'package:fleezy/screens/ListVehiclesScreen.dart';
import 'package:fleezy/screens/ManageCompanyScreen.dart';
import 'package:flutter/material.dart';

const _kOurVehiclesTextStyle =
    TextStyle(fontSize: 30, fontFamily: 'FundamentoRegular');
const _kFleezyTextStyle = TextStyle(
    fontSize: 45,
    fontFamily: 'DancingScript',
    fontWeight: FontWeight.bold,
    color: kHighlightColour);

class HomeScreen extends StatefulWidget {
  static ModelUser user;
  static const String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ManageCompanyScreen manageCompanyScreen = ManageCompanyScreen();
  final ListVehiclesScreen listVehiclesScreen = ListVehiclesScreen();
  final CurrentUserScreen currentUserScreen = CurrentUserScreen();
  int screenIndex = 1;
  List<Widget> _screens = [];
  @override
  void initState() {
    _screens.add(manageCompanyScreen);
    _screens.add(listVehiclesScreen);
    _screens.add(currentUserScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Column(
          children: [
            _HeaderWidget(userName: HomeScreen.user?.phoneNumber ?? ''),
            _screens[screenIndex],
          ],
        ),
        bottomNavBar: BottomNavBar(onTap: (index) {
          screenIndex = index;
          setState(() {});
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
