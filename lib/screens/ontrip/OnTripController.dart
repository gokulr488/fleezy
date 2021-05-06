import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Validator.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class OnTripController {
  String message = '';
  Timer locTimer;
  double distance = 0;
  Position prevPos;

  OnTripController() {
    initLocationService();
  }

  void endTrip(BuildContext context, ModelTrip tripDo) async {
    if (valid(tripDo, context)) {
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
        Navigator.popAndPushNamed(context, HomeScreen.id);
      }
      killTimer();
    }
  }

  bool valid(ModelTrip tripDo, BuildContext context) {
    Validator validate = Validator();
    try {
      validate.doubleField(tripDo.billAmount, 'Enter Bill amount', context);
      validate.doubleField(tripDo.paidAmount, 'Enter Paid Amount', context);
      validate.doubleField(tripDo.driverSalary, 'Enter Driver Salary', context);
      validate.odometerReading(tripDo.endReading, tripDo.startReading, context);
    } catch (e) {
      return false;
    }
    return true;
  }

  onCancelPressed(BuildContext context, ModelTrip tripDo) {
    showWarningAlert(context, 'Are you sure you want to cancel the trip?',
        () => _cancelTrip(tripDo, context, message));
  }

  void _cancelTrip(
      ModelTrip tripDo, BuildContext context, String message) async {
    CallContext callContext = await TripApis().cancelTrip(tripDo, context);
    if (callContext.isError) {
      message = callContext.errorMessage;
      showErrorAlert(context, message);
    } else {
      AppData appData = Provider.of<AppData>(context, listen: false);
      killTimer();
      Vehicle().getVehicleList(appData);
      Navigator.popAndPushNamed(context, HomeScreen.id);
    }
  }

  void initLocationService() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    await calcDistance();
    Timer.periodic(Duration(seconds: 1), (t) {
      locTimer = t;
      calcDistance();
    });
  }

  Future<void> calcDistance() async {
    //if (!await Geolocator.isLocationServiceEnabled()) return;

    Position currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    double accuracy = currentPos.accuracy;
    if (accuracy > 100) {
      return;
    }
    print(currentPos.accuracy);
    if (prevPos == null) {
      prevPos = currentPos;
    }
    double travelledDist = Geolocator.distanceBetween(
      prevPos.latitude,
      prevPos.longitude,
      currentPos.latitude,
      currentPos.longitude,
    );
    prevPos = currentPos;
    distance += travelledDist / 1000;
  }

  void killTimer() {
    if (locTimer != null && locTimer.isActive) {
      locTimer?.cancel();
    }
  }
}
