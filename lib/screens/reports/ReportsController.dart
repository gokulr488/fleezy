import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataAccess/ExpenseApis.dart';
import 'package:fleezy/DataAccess/TripApis.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/screens/reports/ReportProcessor.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportsController {
  static bool thisMnthDataLoaded = false;
  static bool reportReady = false;
  final ReportProcessor processor = ReportProcessor();

  List<String> getFilterValues(ReportData repData) {
    if (repData.filterPeriod == Constants.MONTHLY) return getMonths();
    if (repData.filterPeriod == Constants.QUARTERLY) return _getQuarters();
    if (repData.filterPeriod == Constants.YEARLY) return getYears();
    return [];
  }

  void getCurrentMonthData(BuildContext context) async {
    if (!thisMnthDataLoaded) {
      thisMnthDataLoaded = true;
      DateTime now = DateTime.now();

      CallContext callContext = await TripApis().filterTrips(context, null,
          from: Utils.getStartOfMonth(now), to: Utils.getEndOfMonth(now));
      if (!callContext.isError) {
        processor.processTrips(callContext.data as List<ModelTrip>);
      }

      callContext = await ExpenseApis().filterExpense(context, null,
          from: Utils.getStartOfMonth(now), to: Utils.getEndOfMonth(now));
      if (!callContext.isError) {
        processor.processExpenses(callContext.data as List<ModelExpense>);
      }
    }
    ReportData reportData = Provider.of<ReportData>(context, listen: false);
    reportData.setGeneratedReport(processor.getReportFor('Jul-2021'));
    reportReady = true;
  }

  List<String> getYears() {
    List<String> years = [];
    for (int i = 2018; i <= DateTime.now().year; i++) {
      years.add(i.toString());
    }
    return years;
  }

  List<String> _getQuarters() {
    return [Constants.Q1, Constants.Q2, Constants.Q3, Constants.Q4];
  }

  List<String> getMonths() {
    List<String> months = [];
    for (int i = 1; i <= 12; i++) {
      DateTime now = DateTime(DateTime.now().year, i);
      months.add(DateFormat('MMM').format(now));
    }
    return months;
  }
}
