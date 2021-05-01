import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnTripController {
  void endTrip(BuildContext context, ModelTrip tripDo, String message) async {
    if (valid(tripDo, message)) {
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
    } else {
      showErrorAlert(context, message);
    }
  }

  bool valid(ModelTrip tripDo, String message) {
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

  onCancelPressed(BuildContext context, ModelTrip tripDo, String message) {
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
      Vehicle().getVehicleList(appData);
      Navigator.popAndPushNamed(context, HomeScreen.id);
    }
  }
}
