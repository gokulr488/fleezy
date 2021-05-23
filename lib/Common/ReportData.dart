import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:flutter/cupertino.dart';

class ReportData extends ChangeNotifier {
  ModelReport _generatedReport = ModelReport(
      income: 100000,
      expense: 60000,
      pendingBal: 10000,
      driverSal: 2000,
      totalTrips: 5,
      pendingPayTrips: 2,
      cancelledTrips: 1,
      fineCost: 3000,
      fuelCost: 40000,
      kmsTravelled: 8000,
      ltrs: 4444,
      noOfFines: 2,
      noOfService: 2,
      otherCost: 7000,
      repairCost: 5000,
      reportId: 'KL-01-BQ-4086_JAN-MAR-2021',
      serviceCost: 3000,
      spareCost: 2000);
  Map<String, ModelReport> _reports = {};
  List<ModelTrip> _trips;
  List<ModelExpense> _expenses;

  DateTime _selectedYear = DateTime.now();
  // Timestamp _startDate = Utils.getStartOfMonth(DateTime.now());
  // Timestamp _endDate = Utils.getEndOfMonth(DateTime.now());
  String _filterPeriod = Constants.MONTHLY;

  //Getters
  String get filterPeriod => _filterPeriod;
  DateTime get selectedYear => _selectedYear;
  Map<String, ModelReport> get reports => _reports;
  List<ModelTrip> get trips => _trips;
  List<ModelExpense> get expenses => _expenses;
  ModelReport get generatedReport => _generatedReport;

  void setFilterPeriod(String filterPeriod) {
    _filterPeriod = filterPeriod;
    notifyListeners();
  }

  void setSelectedYear(DateTime selectedYear) {
    _selectedYear = selectedYear;
    notifyListeners();
  }

  addReport(ModelReport report) {
    _reports[report.reportId] = report;
    //notifyListeners();
  }

  addAllReports(List<ModelReport> reports) {
    for (ModelReport report in reports) {
      _reports[report.reportId] = report;
    }
    //notifyListeners();
  }

  setTrips(List<ModelTrip> trips) {
    _trips = trips;
    //notifyListeners(); //check if needed or not
  }

  setExpenses(List<ModelExpense> expenses) {
    _expenses = expenses;
    //notifyListeners();
  }

  setGeneratedReport(ModelReport report) {
    _generatedReport = report;
    notifyListeners();
  }
}
// ReportID naming convention

// combined monthly report => MAY-2021
// vehicle monthly report  => KL-01-BQ-4086_MAY-2021

//combined Quarterly report=> JAN-MAR-2021
//vehicle Quarterly report=> KL-01-BQ-4086_JAN-MAR-2021

//combined yearly report  => 2021
//vehicle yearly report   =>KL-01-BQ-4086_2021
