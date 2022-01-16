import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/DataModels/Quarters.dart';
import 'package:fleezy/DataModels/ReportType.dart';
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
      spareCost: 2000,
      reportType: ReportType.MONTHLY);

  DateTime _selectedYear = DateTime.now();
  // Timestamp _startDate = Utils.getStartOfMonth(DateTime.now());
  // Timestamp _endDate = Utils.getEndOfMonth(DateTime.now());
  ReportType _filterPeriod = ReportType.MONTHLY;
  String _selectedVehicle = 'All';
  String _selectedMonth = Utils.getFormattedDate(DateTime.now(), 'MMM');
  Quarter _selectedQuarter;

  //Getters
  ReportType get filterPeriod => _filterPeriod;
  DateTime get selectedYear => _selectedYear;
  ModelReport get generatedReport => _generatedReport;
  String get selectedVehicle => _selectedVehicle;
  String get selectedMonth => _selectedMonth;
  Quarter get selectedQuarter => _selectedQuarter;

  void setSelectedQuarter(Quarter quarter) {
    _selectedQuarter = quarter;
    notifyListeners();
  }

  void setFilterPeriod(ReportType filterPeriod) {
    _filterPeriod = filterPeriod;
    notifyListeners();
  }

  void setSelectedYear(DateTime selectedYear) {
    _selectedYear = selectedYear;
    notifyListeners();
  }

  void setSelectedMonth(String selectedMonth) {
    _selectedMonth = selectedMonth;
    notifyListeners();
  }

  void setGeneratedReport(ModelReport report) {
    _generatedReport = report;
    notifyListeners();
  }

  void setSelectedVehicle(String selectedVehicle) {
    _selectedVehicle = selectedVehicle;
  }

  String getReportId() {
    String reportId;
    String year = Utils.getFormattedDate(_selectedYear, 'yyyy');
    switch (_filterPeriod) {
      case ReportType.MONTHLY:
        if (_selectedVehicle == 'All') {
          reportId = _selectedMonth + '-' + year;
        } else {
          reportId = _selectedVehicle + '_' + _selectedMonth + '-' + year;
        }
        break;
      case ReportType.QUARTERLY:
        if (_selectedVehicle == 'All') {
          reportId = _selectedQuarter.getString() + '-' + year;
        } else {
          reportId = _selectedVehicle +
              '_' +
              _selectedQuarter.getString() +
              '-' +
              year;
        }
        break;
      case ReportType.YEARLY:
        if (_selectedVehicle == 'All') {
          reportId = year;
        } else {
          reportId = _selectedVehicle + '_' + year;
        }
        break;
      default:
        reportId = '';
    }
    debugPrint('ReportID changed to : $reportId');
    return reportId;
  }
}
// ReportID naming convention

// combined monthly report => MAY-2021
// vehicle monthly report  => KL-01-BQ-4086_MAY-2021

//combined Quarterly report=> JAN-MAR-2021
//vehicle Quarterly report=> KL-01-BQ-4086_JAN-MAR-2021

//combined yearly report  => 2021
//vehicle yearly report   =>KL-01-BQ-4086_2021
