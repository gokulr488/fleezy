import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/ListVehiclesScreen.dart';
import 'package:flutter/material.dart';

class ManageVehicleScreen extends StatefulWidget {
  static const String id = 'manageVehicleScreen';
  @override
  _ManageVehicleScreenState createState() => _ManageVehicleScreenState();
}

class _ManageVehicleScreenState extends State<ManageVehicleScreen> {
  List<String> allowedDrivers = [
    HomeScreen.user.phoneNumber,
    'Shine',
    'Rajesh'
  ];
  @override
  Widget build(BuildContext context) {
    VehicleCard vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          vehicle,
          ButtonCard(
              buttonText: 'Tax Payment', onTap: () => Navigator.pop(context)),
          ButtonCard(
              buttonText: 'Insurance Payment',
              onTap: () => Navigator.pop(context)),
          ButtonCard(
              buttonText: 'Allowed Drivers',
              onTap: () => Navigator.pop(context)),
          SizedBox(height: 15)
        ]));
  }
}
