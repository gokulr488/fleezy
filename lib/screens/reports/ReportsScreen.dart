import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDownButton.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/LoadingDots.dart';
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
    ctrl.getCurrentMonthData(context);
    return BaseScreen(
      headerText: 'Reports',
      child: SingleChildScrollView(
        child: Consumer<ReportData>(
            builder: (BuildContext context, ReportData reportData, _) {
          return ReportsController.reportReady
              ? Column(
                  children: <Widget>[
                    _FilterWidget(),
                    Text(_getSummaryName(reportData.generatedReport.reportId),
                        style: kReportCardHeaderTS),
                    SummaryReportCard(report: reportData.generatedReport),
                    TripSummaryCard(report: reportData.generatedReport),
                    const Text('Expenses', style: kReportCardHeaderTS),
                    const HorLine(),
                    FuelExpensesCard(report: reportData.generatedReport),
                    ServiceRepairCard(report: reportData.generatedReport),
                    FinesOtherExpensesCard(report: reportData.generatedReport),
                  ],
                )
              : const LoadingDots(size: 100);
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
      children: <Widget>[
        Expanded(
          flex: 2,
          child: DropDownButton(
              icon: Icons.calendar_today_outlined,
              hintText: 'Month',
              value: Utils.getFormattedDate(DateTime.now(), 'MMM'),
              values: ctrl.getMonths(),
              onChanged: (String value) {}),
        ),
        Expanded(
          flex: 3,
          child: DropDownButton(
              icon: Icons.drive_eta_rounded,
              hintText: 'Vehicle',
              value: 'All',
              values: ctrl.getVehicleList(context),
              onChanged: (String value) {}),
        ),
        IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async => onFilterClicked(context)),
      ],
    );
  }

  Future<void> onFilterClicked(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return const FilterReportsSheet();
        });
  }
}
