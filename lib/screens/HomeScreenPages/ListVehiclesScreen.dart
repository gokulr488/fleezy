import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/ontrip/OnTripScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListVehiclesScreen extends StatelessWidget {
  static const String id = 'ListVehiclesScreen';

  @override
  Widget build(BuildContext context) {
    _getUserData(context);
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
              decoration: kTextFieldDecoration.copyWith(labelText: 'Search')),
        ],
      ),
    );
  }

  Future<void> _getUserData(BuildContext context) async {
    AppData appData = Provider.of<AppData>(context,
        listen: false); //check if listen false is causing issues here
    if (appData.user == null) {
      print('Getting User basic Info.');
      ModelUser user =
          await Roles().getUser(Authentication().getUser().phoneNumber);
      appData.setUser(user);
      if (user.roleName != Constants.ADMIN) {
        Provider.of<UiState>(context, listen: false).setIsAdmin(false);
      }
      if (user.tripId != null) {
        Navigator.pushReplacementNamed(context, OnTripScreen.id);
      }
    }

    if (appData.availableVehicles.isEmpty) {
      Vehicle().getVehicleList(appData);
    }
  }

  List<VehicleCard> _populateVehicleCards(AppData appData) {
    List<VehicleCard> vehicleCards = [];
    for (ModelVehicle vehicle in appData.availableVehicles) {
      vehicleCards.add(VehicleCard(
          vehicle: vehicle,
          registrationNumber: vehicle.registrationNo,
          color: vehicle.isInTrip ? kActiveColor : kInActiveColor,
          currentDriver: vehicle.currentDriver ?? '',
          message: ModelVehicle.getWarningMessage(vehicle)));
    }
    return vehicleCards;
  }
}
