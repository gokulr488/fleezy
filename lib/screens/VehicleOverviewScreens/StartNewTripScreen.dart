import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';

class StartNewTripScreen extends StatefulWidget {
  static const String id = 'startNewTripScreen';
  @override
  _StartNewTripScreenState createState() => _StartNewTripScreenState();
}

class _StartNewTripScreenState extends State<StartNewTripScreen> {
  VehicleCard vehicle =
      VehicleCard(message: '', currentDriver: '', registrationNumber: '');
  @override
  Widget build(BuildContext context) {
    vehicle = ModalRoute.of(context).settings.arguments;
    String startingFrom = '';
    String goingTo = '';
    String odometerReading = '';
    String customerName = '';
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
                        startingFrom = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Starting From')),
                  TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        goingTo = value;
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: 'Going To')),
                  TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        odometerReading = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Odometer Reading')),
                  TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        customerName = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Customer Name'))
                ]),
              )),
              ButtonCard(
                  buttonText: 'Start Trip', onTap: () => Navigator.pop(context))
            ]));
  }
}
