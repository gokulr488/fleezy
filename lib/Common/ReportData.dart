import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:flutter/cupertino.dart';

class ReportData extends ChangeNotifier {
  Map<String, ModelReport> _reports;
  List<ModelTrip> _trips;
  List<ModelExpense> _expenses;

  DateTime _selectedYear = DateTime.now();
  Timestamp _startDate = Utils.getStartOfMonth(DateTime.now());
  Timestamp _endDate = Utils.getEndOfMonth(DateTime.now());
  String _filterPeriod = Constants.MONTHLY;

  //Getters
  String get filterPeriod => _filterPeriod;
  DateTime get selectedYear => _selectedYear;
  Map<String, ModelReport> get reports => _reports;
  List<ModelTrip> get trips => _trips;
  List<ModelExpense> get expenses => _expenses;

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
    notifyListeners();
  }

  addAllReports(List<ModelReport> reports) {
    for (ModelReport report in reports) {
      _reports[report.reportId] = report;
    }
    notifyListeners();
  }

  setTrips(List<ModelTrip> trips) {
    _trips = trips;
    //notifyListeners(); //check if needed or not
  }

  setExpenses(List<ModelExpense> expenses) {
    _expenses = expenses;
    //notifyListeners();
  }
}
