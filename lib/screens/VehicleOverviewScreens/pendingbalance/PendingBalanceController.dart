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
    List<ModelTrip> pendingBalTrips = appdata.getTripHistoryOf(regNumber);
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
      appdata.setTripHistory(regNumber, tripHistory);
      lastDoc = callContext.pageInfo ?? lastDoc;
    }
  }

  PendingBalanceCard _buildPendingBalCard(ModelTrip trip) {
    return PendingBalanceCard(trip: trip);
  }

  void onRefreshPressed(
      String regNumber, BuildContext context, AppData appdata) {
    lastDoc = null;
    appdata.setPendingBalance(regNumber, []);
    getData(regNumber, context, appdata);
  }
}
