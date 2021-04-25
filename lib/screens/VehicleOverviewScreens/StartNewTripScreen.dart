import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/OnTripScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartNewTripScreen extends StatefulWidget {
  static const String id = 'startNewTripScreen';
  @override
  _StartNewTripScreenState createState() => _StartNewTripScreenState();
}

class _StartNewTripScreenState extends State<StartNewTripScreen> {
  String message = '';
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
                      keyboardType: TextInputType.streetAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        trip.startingFrom = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Starting From')),
                  TextField(
                      keyboardType: TextInputType.streetAddress,
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
                      keyboardType: TextInputType.name,
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
    if (valid()) {
      AppData appData = Provider.of<AppData>(context, listen: false);
      ModelUser user = appData.user;
      trip.driverName = user.fullName ?? user.phoneNumber;
      trip.driverUid = user.uid;
      trip.startDate = Timestamp.now();
      //trip.timestamp = Timestamp.now();
      trip.vehicleRegNo = vehicle.registrationNumber;
      CallContext callContext =
          await TripApis().startNewTrip(trip, vehicle.vehicle, context);
      if (callContext.isError) {
        message = callContext.errorMessage;
        showErrorAlert(context, message);
      } else {
        appData.setTrip(trip);
        Navigator.pushNamed(context, OnTripScreen.id);
      }
    } else {
      showErrorAlert(context, message);
    }
  }

  bool valid() {
    if (trip.startingFrom == null || trip.startingFrom.isEmpty) {
      message = 'Enter Start Location';
      return false;
    }
    if (trip.destination == null || trip.destination.isEmpty) {
      message = 'Enter Destination';
      return false;
    }
    if (trip.customerName == null || trip.customerName.isEmpty) {
      message = 'Enter customer name';
      return false;
    }
    if (trip.startReading < vehicle.vehicle.latestOdometerReading) {
      message = 'Incorrect Odometer Reading';
      return false;
    }
    return true;
  }
}
