import 'dart:async';

import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/LoadingDots.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/TripDetailCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addexpense/AddExpenseScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addfuel/AddFuelScreen.dart';
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
                      distance: controller.distance,
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
                                      onPressed: () => controller
                                          .onCancelPressed(context, tripDo),
                                      colour: kRedColor,
                                      width: 100,
                                    ),
                                    RoundedButton(
                                      title: '+ Expense',
                                      onPressed: () => Navigator.pushNamed(
                                          context, AddExpenseScreen.id,
                                          arguments: tripDo.vehicleRegNo),
                                      width: 100,
                                    ),
                                    RoundedButton(
                                      title: '+ Fuel',
                                      onPressed: () => Navigator.pushNamed(
                                          context, AddFuelScreen.id,
                                          arguments: tripDo.vehicleRegNo),
                                      width: 100,
                                    )
                                  ])
                            ]))),
                    RoundedButton(
                        title: 'End Trip',
                        onPressed: () {
                          controller.endTrip(context, tripDo);
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
