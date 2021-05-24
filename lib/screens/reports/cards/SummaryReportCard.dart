import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';

class SummaryReportCard extends StatelessWidget {
  final ReportsController ctrl;
  final ModelReport report;

  const SummaryReportCard({@required this.report, @required this.ctrl});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Summary',
                style: TextStyle(fontSize: 20, color: kHighlightColour)),
            DataRowWidget(
              field: 'Income',
              value: ctrl.formatDouble(report.income) + ' Rs',
              color: Colors.green[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Pending Balances',
              value: ctrl.formatDouble(report.pendingBal) + ' Rs',
              color: Colors.red[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Driver Salary',
              value: ctrl.formatDouble(report.driverSal) + ' Rs',
              color: Colors.red[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Expenses',
              value: ctrl.formatDouble(report.expense) + ' Rs',
              color: Colors.red[500],
              fontSize: 20,
            ),
            Text('${_getProfit()} Rs',
                style: TextStyle(fontSize: 22, color: Colors.green[500])),
          ],
        ),
      ),
    );
  }

  String _getProfit() {
    double profit =
        report.income - report.expense - report.pendingBal - report.driverSal;
    return ctrl.formatDouble(profit);
  }
}
