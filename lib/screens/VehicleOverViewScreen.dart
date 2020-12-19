import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/AddExpenseScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/AddFuelScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/ManageVehicleScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/StartNewTripScreen.dart';
import 'package:flutter/material.dart';

class VehicleOverviewScreen extends StatefulWidget {
  static const String id = 'vehicleOverviewScreen';
  @override
  _VehicleOverviewScreenState createState() => _VehicleOverviewScreenState();
}

class _VehicleOverviewScreenState extends State<VehicleOverviewScreen> {
  VehicleCard vehicle =
      VehicleCard(message: '', currentDriver: '', registrationNumber: '');
  bool isSuperUser = false;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   vehicle = ModalRoute.of(context).settings.arguments;
    // });
    if (HomeScreen.user.roleName == Constants.ADMIN ||
        HomeScreen.user.roleName == Constants.SUPERUSER) {
      isSuperUser = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      vehicle,
      ButtonCard(
          buttonText: 'Start New Trip',
          onTap: () {
            Navigator.pushNamed(context, StartNewTripScreen.id,
                arguments: vehicle);
          }),
      ButtonCard(
          buttonText: 'Add Fuel',
          onTap: () {
            Navigator.pushNamed(context, AddFuelScreen.id, arguments: vehicle);
          }),
      ButtonCard(
          buttonText: 'Add Expense',
          onTap: () {
            Navigator.pushNamed(context, AddExpenseScreen.id,
                arguments: vehicle);
          }),
      ButtonCard(buttonText: 'Trip History'),
      isSuperUser
          ? ButtonCard(
              buttonText: 'Manage Vehicle',
              onTap: () {
                Navigator.pushNamed(context, ManageVehicleScreen.id,
                    arguments: vehicle);
              })
          : SizedBox()
    ]));
  }
}
