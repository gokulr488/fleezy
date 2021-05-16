import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:flutter/cupertino.dart';

class ReportData extends ChangeNotifier {
  DateTime _selectedYear = DateTime.now();
  Timestamp _startDate = Utils.getStartOfMonth(DateTime.now());
  Timestamp _endDate = Utils.getEndOfMonth(DateTime.now());
  String _filterPeriod = Constants.MONTHLY;

  //Getters
  String get filterPeriod => _filterPeriod;
  DateTime get selectedYear => _selectedYear;

  void setFilterPeriod(String filterPeriod) {
    _filterPeriod = filterPeriod;
    notifyListeners();
  }

  void setSelectedYear(DateTime selectedYear) {
    _selectedYear = selectedYear;
    notifyListeners();
  }
}
