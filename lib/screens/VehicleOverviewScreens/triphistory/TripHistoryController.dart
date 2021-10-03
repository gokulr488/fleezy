import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';

import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/TripOverviewCard.dart';
import 'package:flutter/material.dart';

class TripHistoryController {
  List<TripOverviewCard> tripDetailCards = <TripOverviewCard>[];
  DateTime from;
  DateTime to;

  void onRefreshPressed(
      BuildContext context, String regNumber, AppData appdata) {
    from = null;
    appdata.setTripHistory(regNumber, <ModelTrip>[]);
    getData(regNumber, context, appdata);
  }

  Future<void> getData(
      String regNumber, BuildContext context, AppData appdata) async {
    if (appdata.getTripHistoryOf(regNumber) == null ||
        appdata.getTripHistoryOf(regNumber).isEmpty) {
      await _getDataFromDB(regNumber, context, appdata);
    }
    final List<ModelTrip> tripHistory = appdata.getTripHistoryOf(regNumber);
    tripDetailCards = <TripOverviewCard>[];
    for (final ModelTrip trip in tripHistory) {
      tripDetailCards.add(_buildTripDetailCard(trip));
    }
  }

  TripOverviewCard _buildTripDetailCard(ModelTrip tripDo) {
    return TripOverviewCard(
      tripDo: tripDo,
    );
  }

  Future<void> _getDataFromDB(
      String regNumber, BuildContext context, AppData appdata) async {
    final CallContext callContext = await TripApis()
        .filterTrips(context, 8, regNo: regNumber, from: from, to: to);
    if (!callContext.isError) {
      final List<ModelTrip> tripHistory = callContext.data as List<ModelTrip>;
      appdata.setTripHistory(regNumber, tripHistory);
    }
  }

  void onApplyFilters(BuildContext context, String regNumber, AppData appdata) {
    appdata.setTripHistory(regNumber, <ModelTrip>[]);
    getData(regNumber, context, appdata);
  }
}
