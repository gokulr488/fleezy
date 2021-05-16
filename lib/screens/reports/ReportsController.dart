import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';

List<String> getFilterValues(ReportData repData) {
  if (repData.filterPeriod == Constants.MONTHLY) return _getMonths();
  if (repData.filterPeriod == Constants.QUARTERLY) return _getQuarters();
  if (repData.filterPeriod == Constants.YEARLY) return _getYears();
  return [];
}

List<String> _getYears() {
  List<String> years = [];
  for (int i = 2015; i < 2200; i++) {
    years.add(i.toString());
  }
  return years;
}

List<String> _getQuarters() {
  return [Constants.Q1, Constants.Q2, Constants.Q3, Constants.Q4];
}

List<String> _getMonths() {
  List<String> years = [];
  for (int i = 2015; i < 2200; i++) {
    years.add(i.toString());
  }
  return years;
}
