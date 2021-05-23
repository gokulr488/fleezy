import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';

processTrips(List<ModelTrip> trips, ReportData reportData) {
  for (ModelTrip trip in trips) {
    _processTrip(trip, reportData);
  }
}

void _processTrip(ModelTrip trip, ReportData reportData) {
  String reportId = _getReportId(trip.vehicleRegNo);
  ModelReport vehicleReport = reportData.reports[reportId];
  if (vehicleReport == null) {
    vehicleReport = ModelReport();
  }
  vehicleReport.income += (trip.billAmount ?? 0);
  vehicleReport.kmsTravelled += (trip.distance ?? 0);
  vehicleReport.driverSal += (trip.driverSalary ?? 0);
  vehicleReport.totalTrips++;

  if (trip.balanceAmount != null && trip.balanceAmount > 0) {
    vehicleReport.pendingBal += trip.balanceAmount;
    vehicleReport.pendingPayTrips++;
  }
  if (trip.status == Constants.CANCELLED) {
    vehicleReport.cancelledTrips++;
  }

  reportData.reports[reportId] = vehicleReport;
}

String _getReportId(regNo) {
  //KL-01-BQ-4086_MAY-2021
  return regNo + '_' + Utils.getFormattedDate(DateTime.now(), 'MMM-yyyy');
}
