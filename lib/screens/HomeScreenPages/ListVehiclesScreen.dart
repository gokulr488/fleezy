import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Authentication.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/DataAccess/DAOs/Company.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/StartScreen.dart';
import 'package:fleezy/screens/ontrip/OnTripScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListVehiclesScreen extends StatefulWidget {
  static const String id = 'ListVehiclesScreen';

  @override
  State<ListVehiclesScreen> createState() => _ListVehiclesScreenState();
}

class _ListVehiclesScreenState extends State<ListVehiclesScreen> {
  @override
  void initState() {
    super.initState();
    _getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Our Vehicles', style: kHeaderTextStyle),
        Expanded(
          child: Consumer<AppData>(
              builder: (BuildContext context, AppData appData, _) {
            return ScrollableList(
              childrenHeight: 120,
              items: _populateVehicleCards(appData),
            );
          }),
        ),
        TextField(
            onChanged: (String value) {
              // searchKeyword = value;
            },
            decoration: kTextFieldDecoration.copyWith(labelText: 'Search')),
      ],
    );
  }

  Future<void> _getUserData(BuildContext context) async {
    final AppData appData = Provider.of<AppData>(context,
        listen: false); //check if listen false is causing issues here
    if (appData.user == null) {
      debugPrint('Getting User basic Info.');
      final ModelUser user =
          await Roles().getUser(Authentication().getUser().phoneNumber);
      if (user?.state == Constants.INACTIVE) {
        _logoutUser(context);
        return;
      }
      appData.setUser(user);
      if (appData.selectedCompany == null) {
        debugPrint('Getting Company Info.');
        CallContext callContext =
            await Company().getCompanyById(appData.user.companyId.first);
        if (!callContext.isError) {
          appData.setSelectedCompany(callContext.data);
        }
        if (appData.user.roleName != Constants.ADMIN) {
          Provider.of<UiState>(context, listen: false)
              .setIsAdmin(isAdmin: false);
        }
      }
      if (user?.roleName != Constants.ADMIN) {
        Provider.of<UiState>(context, listen: false).setIsAdmin(isAdmin: false);
      }
      if (user?.tripId != null) {
        await Navigator.pushReplacementNamed(context, OnTripScreen.id);
      }
    }

    if (appData.availableVehicles.isEmpty) {
      Vehicle().getVehicleList(appData);
    }
  }

  List<VehicleCard> _populateVehicleCards(AppData appData) {
    final List<VehicleCard> vehicleCards = <VehicleCard>[];
    for (final ModelVehicle vehicle in appData.availableVehicles) {
      vehicleCards.add(VehicleCard(
          vehicle: vehicle,
          vehicleName: vehicle.vehicleName,
          registrationNumber: vehicle.registrationNo,
          color: vehicle.isInTrip ? kActiveCardColor : kCardOverlay[4],
          currentDriver: vehicle.currentDriver ?? '',
          message: vehicle.getWarningMessage()));
    }
    return vehicleCards;
  }

  void _logoutUser(BuildContext context) {
    Authentication().logout();
    Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
    Navigator.pushReplacementNamed(context, StartScreen.id);
  }
}
