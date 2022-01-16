import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/DataModels/ReportType.dart';
import 'package:fleezy/services/ReportBox.dart';

class ReportProcessor {
  //static final Map<String, ModelReport> _reports = <String, ModelReport>{};
  static List<ModelTrip> _trips;
  static List<ModelExpense> _expenses;
  final ReportBox _reportBox = ReportBox();

  void processTrips(List<ModelTrip> trips) {
    _trips = trips;
    for (final ModelTrip trip in _trips) {
      _processTrip(trip);
    }
  }

  void processExpenses(List<ModelExpense> expenses) {
    _expenses = expenses;
    for (final ModelExpense expense in _expenses) {
      _processExpenses(expense);
    }
  }

  ModelReport getReportFor(String reportId, ReportData reportData) {
    ModelReport report = _reportBox.getByReportId(reportId);
    if (report != null) {
      return report;
    }
    final ModelReport newReport = _buildReport(reportId, reportData);
    _reportBox.put(newReport);
    return newReport;
  }

  ModelReport _buildReport(String reportId, ReportData reportData) {
    ModelReport newReport;
    switch (reportData.filterPeriod) {
      case ReportType.MONTHLY:
        List<ModelReport> reports = _reportBox.getReportsIn(
            year: reportData.selectedYear.year,
            month: reportData.selectedMonth);
        newReport =
            ModelReport(reportId: reportId, reportType: ReportType.MONTHLY);
        combineReports(newReport, reports);
        break;
      case ReportType.QUARTERLY:
        break;
      case ReportType.YEARLY:
        break;
      default:
    }
    return newReport;
  }

  ModelReport combineReports(
      ModelReport target, List<ModelReport> sourceReports) {
    for (ModelReport source in sourceReports) {
      target.companyId = source.companyId;
      target.income += source.income ?? 0;
      target.pendingBal += source.pendingBal ?? 0;
      target.driverSal += source.driverSal ?? 0;
      target.expense += source.expense ?? 0;
      target.totalTrips += source.totalTrips ?? 0;
      target.pendingPayTrips += source.pendingPayTrips ?? 0;
      target.cancelledTrips += source.cancelledTrips ?? 0;
      target.kmsTravelled += source.kmsTravelled ?? 0;
      target.fuelCost += source.fuelCost ?? 0;
      target.ltrs += source.ltrs ?? 0;
      target.serviceCost += source.serviceCost ?? 0;
      target.repairCost += source.repairCost ?? 0;
      target.spareCost += source.spareCost ?? 0;
      target.noOfService += source.noOfService ?? 0;
      target.noOfFines += source.noOfFines ?? 0;
      target.fineCost += source.fineCost ?? 0;
      target.otherCost += source.otherCost ?? 0;
      target.taxInsuranceCost += source.taxInsuranceCost ?? 0;
      target.fastagCost += source.fastagCost ?? 0;
    }

    return target;
  }

  void _processTrip(ModelTrip trip) {
    final String reportId = _getReportId(trip.vehicleRegNo);
    ModelReport vehicleReport = _reportBox.getByReportId(reportId);
    vehicleReport ??=
        ModelReport(reportId: reportId, reportType: ReportType.VEHICLE_MONTHLY);
    vehicleReport.reportId = reportId;
    vehicleReport.income += trip.billAmount ?? 0;
    vehicleReport.kmsTravelled += trip.distance ?? 0;
    vehicleReport.driverSal += trip.driverSalary ?? 0;
    vehicleReport.totalTrips++;

    if (trip.balanceAmount != null && trip.balanceAmount > 0) {
      vehicleReport.pendingBal += trip.balanceAmount;
      vehicleReport.pendingPayTrips++;
    }
    if (trip.status == Constants.CANCELLED) {
      vehicleReport.cancelledTrips++;
    }
    _reportBox.put(vehicleReport);
  }

  String _getReportId(String regNo) {
    //KL-01-BQ-4086_MAY-2021
    return '${regNo}_${Utils.getFormattedDate(DateTime.now(), 'MMM-yyyy')}';
  }

  void _processExpenses(ModelExpense expense) {
    final String reportId = _getReportId(expense.vehicleRegNo);
    ModelReport vehicleReport = _reportBox.getByReportId(reportId);
    vehicleReport ??=
        ModelReport(reportId: reportId, reportType: ReportType.VEHICLE_MONTHLY);
    vehicleReport.reportId = reportId;
    vehicleReport.expense += expense.amount ?? 0;
    switch (expense.expenseType) {
      case Constants.FUEL:
        vehicleReport.fuelCost += expense.amount;
        vehicleReport.ltrs += expense.fuelQty;
        break;
      case Constants.SERVICE:
        vehicleReport.serviceCost += expense.amount;
        vehicleReport.noOfService++;
        break;
      case Constants.REPAIR:
        vehicleReport.repairCost += expense.amount;
        break;
      case Constants.SPARE_PARTS:
        vehicleReport.spareCost += expense.amount;
        break;
      case Constants.FINES:
        vehicleReport.fineCost += expense.amount;
        vehicleReport.noOfFines++;
        break;
      case Constants.OTHER_EXP:
        vehicleReport.otherCost += expense.amount;
        break;
      case Constants.TAX_EXP:
      case Constants.INSURANCE_EXP:
        vehicleReport.taxInsuranceCost += expense.amount;
        break;
      case Constants.FASTAG:
        vehicleReport.fastagCost += expense.amount;
        break;
    }
    _reportBox.put(vehicleReport);
  }
}
