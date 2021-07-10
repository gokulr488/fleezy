import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';

class ReportProcessor {
  static final Map<String, ModelReport> _reports = {};
  static List<ModelTrip> _trips;
  static List<ModelExpense> _expenses;

  void processTrips(List<ModelTrip> trips) {
    _trips = trips;
    for (final trip in trips) {
      _processTrip(trip);
    }
  }

  void processExpenses(List<ModelExpense> expenses) {
    _expenses = expenses;
    for (final expense in expenses) {
      _processExpenses(expense);
    }
  }

  ModelReport getReportFor(String reportId) {
    if (_reports[reportId] != null) {
      return _reports[reportId];
    }
    final newReport = ModelReport(reportId: reportId);
    for (final entry in _reports.entries) {
      if (entry.key.contains(reportId)) {
        combineReports(newReport, entry.value);
      }
    }
    _reports[reportId] = newReport;
    return newReport;
  }

  ModelReport combineReports(ModelReport target, ModelReport source) {
    target.income += (source.income ?? 0);
    target.pendingBal += (source.pendingBal ?? 0);
    target.driverSal += (source.driverSal ?? 0);
    target.expense += (source.expense ?? 0);
    target.totalTrips += (source.totalTrips ?? 0);
    target.pendingPayTrips += (source.pendingPayTrips ?? 0);
    target.cancelledTrips += (source.cancelledTrips ?? 0);
    target.kmsTravelled += (source.kmsTravelled ?? 0);
    target.fuelCost += (source.fuelCost ?? 0);
    target.ltrs += (source.ltrs ?? 0);
    target.serviceCost += (source.serviceCost ?? 0);
    target.repairCost += (source.repairCost ?? 0);
    target.spareCost += (source.spareCost ?? 0);
    target.noOfService += (source.noOfService ?? 0);
    target.noOfFines += (source.noOfFines ?? 0);
    target.fineCost += (source.fineCost ?? 0);
    target.otherCost += (source.otherCost ?? 0);
    return target;
  }

  void _processTrip(ModelTrip trip) {
    final reportId = _getReportId(trip.vehicleRegNo);
    var vehicleReport = _reports[reportId];
    vehicleReport ??= ModelReport();

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

    _reports[reportId] = vehicleReport;
  }

  String _getReportId(regNo) {
    //KL-01-BQ-4086_MAY-2021
    return regNo + '_' + Utils.getFormattedDate(DateTime.now(), 'MMM-yyyy');
  }

  void _processExpenses(ModelExpense expense) {
    final reportId = _getReportId(expense.vehicleRegNo);
    var vehicleReport = _reports[reportId];
    vehicleReport ??= ModelReport();

    vehicleReport.expense += (expense.amount ?? 0);
    if (expense.expenseType == Constants.FUEL) {
      vehicleReport.fuelCost += (expense.amount);
      vehicleReport.ltrs += (expense.fuelQty);
    }
    if (expense.expenseType == Constants.SERVICE) {
      vehicleReport.serviceCost += (expense.amount);
      vehicleReport.noOfService++;
    }
    if (expense.expenseType == Constants.REPAIR) {
      vehicleReport.repairCost += (expense.amount);
    }
    if (expense.expenseType == Constants.SPARE_PARTS) {
      vehicleReport.spareCost += (expense.amount);
    }
    if (expense.expenseType == Constants.FINES) {
      vehicleReport.fineCost += (expense.amount);
      vehicleReport.noOfFines++;
    }
    if (expense.expenseType == Constants.OTHER_EXP) {
      vehicleReport.otherCost += (expense.amount);
    }

    _reports[reportId] = vehicleReport;
  }
}
