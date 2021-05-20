import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceCard.dart';

import 'package:flutter/material.dart';

class PendingBalanceController {
  List<PendingBalanceCard> pendingBalCards = [];
  DocumentSnapshot lastDoc;

  void getData(String regNumber, BuildContext context, AppData appdata) async {
    List<ModelTrip> pendingBalTrips;
    if (regNumber == null) {
      if (appdata.getAllPendingBalances() == null ||
          appdata.getAllPendingBalances().isEmpty) {
        await _getDataFromDB(regNumber, context, appdata);
      }
      pendingBalTrips = appdata.getAllPendingBalances();
    } else {
      if (appdata.getPendingBalanceOf(regNumber) == null ||
          appdata.getPendingBalanceOf(regNumber).isEmpty) {
        await _getDataFromDB(regNumber, context, appdata);
      }
      pendingBalTrips = appdata.getPendingBalanceOf(regNumber);
    }

    pendingBalCards = [];
    for (ModelTrip trip in pendingBalTrips) {
      pendingBalCards.add(_buildPendingBalCard(trip));
    }
  }

  void _getDataFromDB(
      String regNumber, BuildContext context, AppData appdata) async {
    CallContext callContext =
        await TripApis().getPendingBalanceTrips(context, regNumber, lastDoc);
    if (!callContext.isError) {
      List<ModelTrip> tripHistory = callContext.data as List<ModelTrip>;
      for (ModelTrip trip in tripHistory) {
        appdata.addPendingBalance(trip.vehicleRegNo, trip);
      }

      lastDoc = callContext.pageInfo ?? lastDoc;
    }
  }

  PendingBalanceCard _buildPendingBalCard(ModelTrip trip) {
    return PendingBalanceCard(trip: trip);
  }

  void onRefreshPressed(
      String regNumber, BuildContext context, AppData appdata) {
    lastDoc = null;
    appdata.resetPendingBalances();
    getData(regNumber, context, appdata);
  }

  onPendingBalanceSave(
      BuildContext context, ModelTrip trip, String amount, bool isIgnore) {
    if (isIgnore) {
      showWarningAlert(context, 'Ignore the pending balance of $amount Rs ?',
          () => ignorePendingBalance(context, trip));
    } else {
      showWarningAlert(context, 'Pending Balance of $amount Rs received ?',
          () => pendingBalanceReceived(context, trip));
    }
  }

  void ignorePendingBalance(BuildContext context, ModelTrip trip) {
    print(trip);
  }

  void pendingBalanceReceived(BuildContext context, ModelTrip trip) {}

  bool valid(BuildContext context, ModelTrip trip, String balanceReceived,
      bool ignorePending) {
    return true;
  }
}
