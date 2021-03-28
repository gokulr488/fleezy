import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Trip.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartNewTripScreen extends StatefulWidget {
  static const String id = 'startNewTripScreen';
  @override
  _StartNewTripScreenState createState() => _StartNewTripScreenState();
}

class _StartNewTripScreenState extends State<StartNewTripScreen> {
  VehicleCard vehicle =
      VehicleCard(message: '', currentDriver: '', registrationNumber: '');
  ModelTrip trip = ModelTrip();
  @override
  Widget build(BuildContext context) {
    vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
        headerText: 'Start New Trip',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              vehicle,
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ScrollableList(childrenHeight: 80, items: [
                  TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        trip.startingFrom = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Starting From')),
                  TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        trip.destination = value;
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: 'Going To')),
                  TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        trip.startReading = int.parse(value);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Odometer Reading')),
                  TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        trip.customerName = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Customer Name'))
                ]),
              )),
              ButtonCard(
                  buttonText: 'Start Trip',
                  onTap: () {
                    _startTrip(context);
                  })
            ]));
  }

  void _startTrip(BuildContext context) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    trip.driverName = user.fullName ?? user.phoneNumber;
    trip.driverUid = user.uid;
    trip.startDate = Timestamp.now();
    trip.timestamp = Timestamp.now();
    trip.vehicleRegNo = vehicle.registrationNumber;
    await Trip().addTrip(trip, user.companyId);
  }
}
