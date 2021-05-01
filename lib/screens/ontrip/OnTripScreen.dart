import 'dart:async';

import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/AddFuelScreen.dart';
import 'package:fleezy/screens/ontrip/OnTripController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTripScreen extends StatefulWidget {
  static const String id = 'OnTripScreen';
  @override
  _OnTripScreenState createState() => _OnTripScreenState();
}

class _OnTripScreenState extends State<OnTripScreen> {
  OnTripController controller;
  Timer timer;
  ModelTrip tripDo;
  String message = '';

  @override
  void initState() {
    super.initState();
    controller = OnTripController();
    Timer.periodic(Duration(seconds: 1), (t) {
      timer = t;
      setState(() {});
    });
  }

  @override
  void deactivate() {
    timer?.cancel();
    super.deactivate();
  }

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
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    RoundedButton(
                                      title: 'Cancel Trip',
                                      onPressed: () =>
                                          controller.onCancelPressed(
                                              context, tripDo, message),
                                      colour: kRedColor,
                                      width: 130,
                                    ),
                                    RoundedButton(
                                      title: 'Add Fuel',
                                      onPressed: () => Navigator.pushNamed(
                                          context, AddFuelScreen.id,
                                          arguments: tripDo.vehicleRegNo),
                                      width: 130,
                                    )
                                  ])
                            ]))),
                    RoundedButton(
                        title: 'End Trip',
                        onPressed: () {
                          controller.endTrip(context, tripDo, message);
                        })
                  ])
            : LoadingDots(size: 100));
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
