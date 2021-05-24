import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';

class ReportProcessor {
  static Map<String, ModelReport> _reports = {};
  static List<ModelTrip> _trips;
  static List<ModelExpense> _expenses;

  processTrips(List<ModelTrip> trips) {
    _trips = trips;
    for (ModelTrip trip in trips) {
      _processTrip(trip);
    }
  }

  processExpenses(List<ModelExpense> expenses) {
    _expenses = expenses;
    for (ModelExpense expense in expenses) {
      _processExpenses(expense);
    }
  }

  void _processTrip(ModelTrip trip) {
    String reportId = _getReportId(trip.vehicleRegNo);
    ModelReport vehicleReport = _reports[reportId];
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

    _reports[reportId] = vehicleReport;
  }

  String _getReportId(regNo) {
    //KL-01-BQ-4086_MAY-2021
    return regNo + '_' + Utils.getFormattedDate(DateTime.now(), 'MMM-yyyy');
  }

  void _processExpenses(ModelExpense expense) {
    String reportId = _getReportId(expense.vehicleRegNo);
    ModelReport vehicleReport = _reports[reportId];
    if (vehicleReport == null) {
      vehicleReport = ModelReport();
    }
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
