import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
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
    //TODO logic for ending trip and timer
    if (valid()) {
      ModelUser user = Provider.of<AppData>(context, listen: false).user;
      tripDo.driverName = user.fullName ?? user.phoneNumber;
      tripDo.driverUid = user.uid;
      tripDo.startDate = Timestamp.now();
      tripDo.timestamp = Timestamp.now();
    } else {
      showErrorAlert(context, message);
    }
  }

  bool valid() {
    if (tripDo.billAmount == null || tripDo.billAmount == 0) {
      message = 'Enter Bill amount';
      return false;
    }
    if (tripDo.paidAmount == null || tripDo.paidAmount == 0) {
      message = 'Enter Paid Amount';
      return false;
    }
    if (tripDo.driverSalary == null || tripDo.driverSalary == 0) {
      message = 'Enter Driver Salary';
      return false;
    }
    if (tripDo.endReading == null ||
        tripDo.endReading == 0 ||
        tripDo.endReading < tripDo.startReading) {
      message = 'Incorrect Odometer Reading';
      return false;
    }
    return true;
  }
}
