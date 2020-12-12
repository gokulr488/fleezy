import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          vehicle,
          TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                startingFrom = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Starting From')),
          TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                goingTo = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Going To')),
          TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                odometerReading = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Odometer Reading')),
          TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                customerName = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Customer Name')),
          ButtonCard(
              buttonText: 'Start Trip', onTap: () => Navigator.pop(context))
        ]));
  }
}
