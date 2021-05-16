import 'package:fleezy/Common/Constants.dart';
import 'package:flutter/cupertino.dart';

class ReportData extends ChangeNotifier {
  String _filterPeriod = Constants.MONTHLY;

  //Getters
  String get filterPeriod => _filterPeriod;

  void setFilterPeriod(String filterPeriod) {
    _filterPeriod = filterPeriod;
    notifyListeners();
  }
}
