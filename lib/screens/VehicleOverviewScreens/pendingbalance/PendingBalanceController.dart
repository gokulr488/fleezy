import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/DataAccess/DAOs/Trip.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceCard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    for (final trip in pendingBalTrips) {
      pendingBalCards.add(_buildPendingBalCard(trip));
    }
  }

  Future<void> _getDataFromDB(
      String regNumber, BuildContext context, AppData appdata) async {
    final callContext =
        await TripApis().getPendingBalanceTrips(context, regNumber, lastDoc);
    if (!callContext.isError) {
      final tripHistory = callContext.data as List<ModelTrip>;
      for (final trip in tripHistory) {
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

  Future<void> onPendingBalanceSave(BuildContext context, ModelTrip trip,
      String amount, bool isIgnore, Function updateUi) async {
    if (isIgnore) {
      showWarningAlert(context, 'Ignore the pending balance of $amount Rs ?',
          () async {
        await ignorePendingBalance(context, trip);
        updateUi.call();
      });
    } else {
      showWarningAlert(context, 'Pending Balance of $amount Rs received ?',
          () async {
        await pendingBalanceReceived(context, trip, amount);
        updateUi.call();
      });
    }
  }

  Future<void> ignorePendingBalance(
      BuildContext context, ModelTrip trip) async {
    trip.billAmount -= trip.balanceAmount;
    trip.balanceAmount = 0;
    Navigator.pop(context);
    final appData = Provider.of<AppData>(context, listen: false);
    final callContext = await Trip().updateTrip(trip, appData?.user?.companyId);
    if (callContext.isError) {
      showErrorAlert(context, callContext.errorMessage);
    } else {
      showSubmitResponse(context, 'Pending Balance ignored');
    }
  }

  Future<void> pendingBalanceReceived(
      BuildContext context, ModelTrip trip, String amount) async {
    trip.balanceAmount -= int.parse(amount);
    Navigator.pop(context);
    final appData = Provider.of<AppData>(context, listen: false);
    final callContext = await Trip().updateTrip(trip, appData?.user?.companyId);
    if (callContext.isError) {
      showErrorAlert(context, callContext.errorMessage);
    } else {
      showSubmitResponse(context, '$amount Rs Received');
    }
  }

  bool valid(BuildContext context, ModelTrip trip, String balanceReceived,
      bool ignorePending) {
    if (!ignorePending) {
      if (trip.balanceAmount < int.parse(balanceReceived)) {
        return false;
      }
    }
    return true;
  }
}
