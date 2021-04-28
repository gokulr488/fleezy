import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/AddExpenseScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/AddFuelScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/StartNewTripScreen.dart';
import 'package:flutter/material.dart';

class VehicleOverviewScreen extends StatelessWidget {
  static const String id = 'vehicleOverviewScreen';
  @override
  Widget build(BuildContext context) {
    VehicleCard vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
        headerText: 'Vehicle Overview',
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          vehicle,
          ButtonCard(
              buttonText: 'Start New Trip',
              onTap: () {
                if (!vehicle.vehicle.isInTrip) {
                  Navigator.pushNamed(context, StartNewTripScreen.id,
                      arguments: vehicle);
                } else {
                  showErrorAlert(context, "Already in TRIP");
                }
              }),
          ButtonCard(
              buttonText: 'Add Fuel',
              onTap: () {
                if (!vehicle.vehicle.isInTrip) {
                  Navigator.pushNamed(context, AddFuelScreen.id,
                      arguments: vehicle.vehicle.registrationNo);
                } else {
                  showErrorAlert(context, "Cannot add. Vehicle in use");
                }
              }),
          ButtonCard(
              buttonText: 'Add Expense',
              onTap: () {
                Navigator.pushNamed(context, AddExpenseScreen.id,
                    arguments: vehicle);
              }),
          ButtonCard(buttonText: 'Trip History'),
        ]));
  }
}
