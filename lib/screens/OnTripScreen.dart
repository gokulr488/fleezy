import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
import 'package:fleezy/screens/HomeScreen.dart';
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
    if (tripDo == null) {
      _getTripDo(context);
    }
    return BaseScreen(
        headerText: 'Trip Started',
        child: tripDo != null
            ? Column(
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
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              tripDo.billAmount = double.parse(value);
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Bill Amount')),
                        TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              tripDo.paidAmount = double.parse(value);
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Paid Amount')),
                        TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              tripDo.driverSalary = double.parse(value);
                            },
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Driver Salary')),
                        TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              tripDo.endReading = int.parse(value);
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
                  ])
            : LoadingDots(size: 100));
  }

  void _endTrip(BuildContext context) async {
    //TODO  timer
    if (valid()) {
      tripDo.endDate = Timestamp.now();
      tripDo.balanceAmount = tripDo.billAmount - tripDo.paidAmount;
      tripDo.distance = tripDo.endReading - tripDo.startReading;
      CallContext callContext = await TripApis().endTrip(tripDo, context);
      if (callContext.isError) {
        message = callContext.errorMessage;
        showErrorAlert(context, message);
      } else {
        AppData appData = Provider.of<AppData>(context, listen: false);
        Vehicle().getVehicleList(appData);
        appData.setAvailableVehicles([]);
        if (Navigator.canPop(context)) {
          Navigator.popUntil(context, ModalRoute.withName(HomeScreen.id));
        } else {
          Navigator.popAndPushNamed(context, HomeScreen.id);
        }
      }
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

  void _getTripDo(BuildContext context) async {
    AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData.trip != null) {
      tripDo = appData.trip;
    } else {
      try {
        tripDo = await TripApis()
            .getTripById(appData.user.tripId, appData.user.companyId);
      } catch (e) {}
    }
    setState(() {});
  }
}
