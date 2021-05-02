import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
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
    Timer.periodic(Duration(seconds: 1), (t) {
      locTimer = t;
      calcDistance();
    });
  }

  void endTrip(BuildContext context, ModelTrip tripDo) async {
    if (valid(tripDo)) {
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
    } else {
      showErrorAlert(context, message);
    }
  }

  bool valid(ModelTrip tripDo) {
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
  }

  void calcDistance() async {
    Position currentPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    double accuracy = currentPos.accuracy;
    if (accuracy > 50) {
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
    distance += travelledDist / 1000;
  }

  void killTimer() {
    if (locTimer.isActive) {
      locTimer?.cancel();
    }
  }

  // void initLocationService() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   location.changeSettings(
  //       accuracy: LocationAccuracy.high, interval: 100, distanceFilter: 0);

  //   location.onLocationChanged.listen((LocationData currentLocation) {
  //     if (previousLocation == null) {
  //       previousLocation = currentLocation;
  //     }

  //     double kms = Utils.calculateDistance(
  //         previousLocation.latitude,
  //         previousLocation.longitude,
  //         currentLocation.latitude,
  //         currentLocation.longitude);

  //     distance += kms;
  //     print('Kms traveled: $distance');
  //   });
  // }
}
