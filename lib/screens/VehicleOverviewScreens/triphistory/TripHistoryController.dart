import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/TripOverviewCard.dart';
import 'package:flutter/src/widgets/framework.dart';

class TripHistoryController {
  List<TripOverviewCard> tripDetailCards = [];
  DateTime date;

  onRefreshPressed(BuildContext context, String regNumber, AppData appdata) {
    date = null;
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
    CallContext callContext =
        await TripApis().filterTrips(context, regNo: regNumber, date: date);
    if (!callContext.isError) {
      List<ModelTrip> tripHistory = callContext.data as List<ModelTrip>;
      appdata.setTripHistory(regNumber, tripHistory);
    }
  }

  void onDateSelected(BuildContext context, String regNumber, AppData appdata) {
    appdata.setTripHistory(regNumber, []);
    getData(regNumber, context, appdata);
  }

  String getDateString() {
    if (date == null) {
      return 'Filter';
    }
    return Utils.getFormattedDate(date, kDateFormat);
  }
}
