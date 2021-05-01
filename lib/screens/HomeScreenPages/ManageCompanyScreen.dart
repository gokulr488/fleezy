import 'package:fleezy/components/GridLayout.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/screens/ManageDriverScreens/ManageDriversScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehiclesScreen.dart';
import 'package:flutter/material.dart';

class ManageCompanyScreen extends StatefulWidget {
  @override
  _ManageCompanyScreenState createState() => _ManageCompanyScreenState();
}

class _ManageCompanyScreenState extends State<ManageCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return GridLayout(children: [
      ButtonCard(
          text: 'Manage Vehicles',
          onTap: () {
            Navigator.pushNamed(context, ManageVehiclesScreen.id);
          }),
      ButtonCard(
          text: 'Manage Drivers',
          onTap: () {
            Navigator.pushNamed(context, ManageDriversScreen.id);
          }),
      ButtonCard(
          text: 'Reports',
          onTap: () {
            // Navigator.pushNamed(context, ManageDriversScreen.id);
          })
    ]);
  }
}
