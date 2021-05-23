import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:intl/intl.dart';

List<String> getFilterValues(ReportData repData) {
  if (repData.filterPeriod == Constants.MONTHLY) return getMonths();
  if (repData.filterPeriod == Constants.QUARTERLY) return _getQuarters();
  if (repData.filterPeriod == Constants.YEARLY) return getYears();
  return [];
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

final curFormat = NumberFormat("##,##,##,##0.00");

String formatNumber(double value) {
  if (value == null) return '0.00';
  return curFormat.format(value);
}

String formatNumberNoDec(double value) {
  if (value == null) return '0.00';
  return value.toStringAsFixed(0);
}
