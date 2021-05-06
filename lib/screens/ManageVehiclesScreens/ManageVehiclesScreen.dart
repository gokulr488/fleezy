import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ManageVehicleCard.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/AddVehicleScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const TextStyle headerStyle =
    TextStyle(fontSize: 30, fontFamily: 'FundamentoRegular');

class ManageVehiclesScreen extends StatelessWidget {
  static const String id = 'ManageVehiclesScreen';
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        headerText: 'Manage Vehicles',
        child: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Consumer<AppData>(builder: (context, appData, _) {
              List<ManageVehicleCard> vehicleCards = [];
              for (ModelVehicle vehicle in appData.availableVehicles ?? []) {
                vehicleCards.add(buildVehicleCard(vehicle));
              }
              return ScrollableList(childrenHeight: 120, items: vehicleCards);
            }),
          )),
          RoundedButton(
              title: 'Add New Vehicle',
              onPressed: () {
                Navigator.pushNamed(context, AddVehicleScreen.id);
              })
        ]));
  }

  ManageVehicleCard buildVehicleCard(ModelVehicle vehicle) {
    return ManageVehicleCard(
        registrationNumber: vehicle.registrationNo,
        color: vehicle.isInTrip ? kActiveTextColor : kCardOverlay[4],
        currentDriver: vehicle.currentDriver ?? '',
        vehicle: vehicle,
        message: ModelVehicle.getWarningMessage(vehicle));
  }
}
