import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryController.dart';
import 'package:flutter/material.dart';

class PendingBalanceController extends TripHistoryController {
  List<PendingBalanceCard> pendingBalCards = [];

  @override
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
    CallContext callContext = await TripApis().filterTrips(context,
        regNo: regNumber, from: from, to: to, hasBalance: true);
    if (!callContext.isError) {
      List<ModelTrip> tripHistory = callContext.data as List<ModelTrip>;
      appdata.setTripHistory(regNumber, tripHistory);
    }
  }

  PendingBalanceCard _buildPendingBalCard(ModelTrip trip) {}
}
