import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTripScreen extends StatefulWidget {
  static const String id = 'OnTripScreen';
  @override
  _OnTripScreenState createState() => _OnTripScreenState();
}

class _OnTripScreenState extends State<OnTripScreen> {
  String message = '';
  ModelTrip tripDo;
  @override
  Widget build(BuildContext context) {
    tripDo = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
        headerText: 'Trip Started',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TripDetailCard(
                tripDo: tripDo,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ScrollableList(childrenHeight: 80, items: [
                  TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        tripDo.startingFrom = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Bill Amount')),
                  TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        tripDo.destination = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Paid Amount')),
                  TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        tripDo.destination = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Driver Salary')),
                  TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        tripDo.startReading = int.parse(value);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Odometer Reading')),
                ]),
              )),
              ButtonCard(
                  buttonText: 'End Trip',
                  onTap: () {
                    _endTrip(context);
                  })
            ]));
  }

  void _endTrip(BuildContext context) async {
    if (valid()) {
      ModelUser user = Provider.of<AppData>(context, listen: false).user;
      tripDo.driverName = user.fullName ?? user.phoneNumber;
      tripDo.driverUid = user.uid;
      tripDo.startDate = Timestamp.now();
      tripDo.timestamp = Timestamp.now();
    }
  }

  bool valid() {
    if (tripDo.startingFrom == null || tripDo.startingFrom.isEmpty) {
      message = 'Enter Start Location';
      return false;
    }
    if (tripDo.destination == null || tripDo.destination.isEmpty) {
      message = 'Enter Destination';
      return false;
    }
    if (tripDo.customerName == null || tripDo.customerName.isEmpty) {
      message = 'Enter customer name';
      return false;
    }
    return true;
  }
}
