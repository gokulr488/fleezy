import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';

class ManageVehicleScreen extends StatelessWidget {
  static const String id = 'manageVehicleScreen';
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
