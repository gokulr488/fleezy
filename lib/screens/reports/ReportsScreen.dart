import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDownButton.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/screens/reports/FilterReportsSheet.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:fleezy/screens/reports/cards/FinesOtherExpenseCard.dart';
import 'package:fleezy/screens/reports/cards/FuelExpensesCard.dart';
import 'package:fleezy/screens/reports/cards/ServiceRepairCard.dart';
import 'package:fleezy/screens/reports/cards/SummaryReportCard.dart';
import 'package:fleezy/screens/reports/cards/TripsSummaryCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {
  static const String id = 'ReportsScreen';
  final ReportsController ctrl = ReportsController();
  @override
  Widget build(BuildContext context) {
    List<String> expenses = ['All', 'Fuel', 'June'];
    ctrl.getCurrentMonthData(context);
    expenses.addAll(Constants.EXPENSE_TYPES);
    return BaseScreen(
      headerText: 'Reports',
      child: SingleChildScrollView(
        child: Consumer<ReportData>(builder: (context, reportData, _) {
          return Column(
            children: [
              _FilterWidget(),
              Text(_getSummaryName(reportData.generatedReport.reportId),
                  style: TextStyle(fontSize: 21, color: kHighlightColour)),
              SummaryReportCard(report: reportData.generatedReport),
              TripSummaryCard(report: reportData.generatedReport),
              Text(
                'Expenses',
                style: TextStyle(fontSize: 20, color: Colors.red[500]),
              ),
              HorLine(),
              FuelExpensesCard(report: reportData.generatedReport),
              ServiceRepairCard(report: reportData.generatedReport),
              FinesOtherExpensesCard(report: reportData.generatedReport),
            ],
          );
        }),
      ),
    );
  }

  String _getSummaryName(String reportId) {
    if (!reportId.contains('_')) return reportId;

    // List<String> parts = reportId.split('_');
    // return parts[1];
    return reportId.replaceAll('_', '   ');
  }
}

class _FilterWidget extends StatelessWidget {
  final ReportsController ctrl = ReportsController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 40,
          child: DropDownButton(
              icon: Icons.calendar_today,
              hintText: 'Month',
              value: 'May',
              values: ctrl.getMonths(),
              onChanged: (String value) {}),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 40,
          child: DropDownButton(
              icon: Icons.drive_eta_rounded,
              hintText: 'Vehicle',
              value: 'All',
              values: ['All', 'Fortuner', 'Duke'],
              onChanged: (String value) {}),
        ),
        IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async => onFilterClicked(context)),
      ],
    );
  }

  void onFilterClicked(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (builder) {
          return FilterReportsSheet();
        });
  }
}
