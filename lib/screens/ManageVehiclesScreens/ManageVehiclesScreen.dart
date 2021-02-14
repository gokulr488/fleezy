import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/AddVehicleScreen.dart';
import 'package:flutter/material.dart';

class ManageVehiclesScreen extends StatelessWidget {
  static const String id = 'ManageVehiclesScreen';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Column(children: [
      ButtonCard(
          buttonText: 'Add New Vehicle',
          onTap: () {
            Navigator.pushNamed(context, AddVehicleScreen.id);
          })
    ]));
  }
}
