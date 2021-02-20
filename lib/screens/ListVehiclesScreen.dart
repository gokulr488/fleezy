import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Roles.dart';
import 'package:fleezy/DataAccess/Vehicle.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const kWelcomeUserTextStyle = TextStyle(
    fontSize: 18, fontFamily: 'FundamentoRegular', fontWeight: FontWeight.bold);

class ListVehiclesScreen extends StatelessWidget {
  static const String id = 'ListVehiclesScreen';

  @override
  Widget build(BuildContext context) {
    _getUserData(Provider.of<AppData>(context));
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Consumer<AppData>(builder: (context, appData, _) {
              return ScrollableList(
                childrenHeight: 120,
                items: _populateVehicleCards(appData),
              );
            }),
          ),
          TextField(
              onChanged: (value) {
                // searchKeyword = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Search')),
        ],
      ),
    );
  }

  Future<void> _getUserData(AppData appData) async {
    if (appData.user == null) {
      print('Getting User basic Info.');
      ModelUser user =
          await Roles().getUser(Authentication().getUser().phoneNumber);
      appData.setUser(user);
    }
    if (appData.availableVehicles.isEmpty) {
      _getVehicleList(appData);
    }
  }

  void _getVehicleList(AppData appData) async {
    List<ModelVehicle> vehiclesData =
        await Vehicle().getVehiclesForUser(appData.user);
    if (vehiclesData != null && vehiclesData.isNotEmpty) {
      appData.setAvailableVehicles(vehiclesData);
    }
  }

  List<VehicleCard> _populateVehicleCards(AppData appData) {
    List<VehicleCard> vehicleCards = [];
    for (ModelVehicle vehicle in appData.availableVehicles) {
      vehicleCards.add(VehicleCard(
          registrationNumber: vehicle.registrationNo,
          color: vehicle.isInTrip ? kActiveVehicleColor : kInActiveVehicleColor,
          currentDriver: vehicle.currentDriver ?? '',
          message: ModelVehicle.getWarningMessage(vehicle)));
    }
    return vehicleCards;
  }
}
