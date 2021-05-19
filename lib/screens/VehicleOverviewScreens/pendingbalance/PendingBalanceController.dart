import 'package:cloud_firestore/cloud_firestore.dart';
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
    if (appdata.getTripHistoryOf(regNumber) == null ||
        appdata.getTripHistoryOf(regNumber).isEmpty) {
      await _getDataFromDB(regNumber, context, appdata);
    }
    List<ModelTrip> pendingBalTrips = appdata.getPendingBalanceOf(regNumber);
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
}
