import 'package:fleezy/Common/AppData.dart';

import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/TripOverviewCard.dart';
import 'package:flutter/src/widgets/framework.dart';

class TripHistoryController {
  List<TripOverviewCard> tripDetailCards = [];
  DateTime from;
  DateTime to;

  void onRefreshPressed(
      BuildContext context, String regNumber, AppData appdata) {
    from = null;
    appdata.setTripHistory(regNumber, []);
    getData(regNumber, context, appdata);
  }

  void getData(String regNumber, BuildContext context, AppData appdata) async {
    if (appdata.getTripHistoryOf(regNumber) == null ||
        appdata.getTripHistoryOf(regNumber).isEmpty) {
      await _getDataFromDB(regNumber, context, appdata);
    }
    final tripHistory = appdata.getTripHistoryOf(regNumber);
    tripDetailCards = [];
    for (final trip in tripHistory) {
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
    final callContext = await TripApis()
        .filterTrips(context, 8, regNo: regNumber, from: from, to: to);
    if (!callContext.isError) {
      final tripHistory = callContext.data as List<ModelTrip>;
      appdata.setTripHistory(regNumber, tripHistory);
    }
  }

  void onApplyFilters(BuildContext context, String regNumber, AppData appdata) {
    appdata.setTripHistory(regNumber, []);
    getData(regNumber, context, appdata);
  }
}
