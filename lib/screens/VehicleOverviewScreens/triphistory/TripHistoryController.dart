import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/TripOverviewCard.dart';
import 'package:flutter/src/widgets/framework.dart';

List<TripOverviewCard> tripDetailCards = [];
Timestamp date;

onRefreshPressed(BuildContext context, String regNumber, AppData appdata) {
  appdata.setTripHistory(regNumber, []);
  getData(regNumber, context, appdata);
}

void getData(String regNumber, BuildContext context, AppData appdata) async {
  if (appdata.getTripHistoryOf(regNumber) == null ||
      appdata.getTripHistoryOf(regNumber).isEmpty) {
    await _getDataFromDB(regNumber, context, appdata);
  }
  List<ModelTrip> tripHistory = appdata.getTripHistoryOf(regNumber);
  tripDetailCards = [];
  for (ModelTrip trip in tripHistory) {
    tripDetailCards.add(_buildTripDetailCard(trip));
  }
}

TripOverviewCard _buildTripDetailCard(ModelTrip tripDo) {
  return TripOverviewCard(
    tripDo: tripDo,
  );
}

void _getDataFromDB(
    String regNumber, BuildContext context, AppData appdata) async {
  // CallContext callContext = await TripApis().getAllTripsOf(regNumber, context);
  CallContext callContext =
      await TripApis().filterTrips(context, regNo: regNumber, date: date);
  if (!callContext.isError) {
    List<ModelTrip> tripHistory = callContext.data as List<ModelTrip>;
    appdata.setTripHistory(regNumber, tripHistory);
  }
}

String getDateString() {
  if (date == null) {
    return 'Choose Date';
  }
  return Utils.getFormattedTimeStamp(date);
}
