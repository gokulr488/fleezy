import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';

class SummaryReportCard extends StatelessWidget {
  final ModelReport report;

  const SummaryReportCard({@required this.report});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(_getSummaryName(report.reportId) + ' Summary',
                style: TextStyle(fontSize: 22, color: kHighlightColour)),
            DataRowWidget(
              field: 'Income',
              value: formatNumber(report.income) + ' Rs',
              color: Colors.green[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Pending Balances',
              value: formatNumber(report.pendingBal) + ' Rs',
              color: Colors.red[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Expense',
              value: formatNumber(report.expense) + ' Rs',
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

//TODO add driver salary column and make correction to profit calculation
  String _getSummaryName(String reportId) {
    if (!reportId.contains('_')) return reportId;

    List<String> parts = reportId.split('_');
    return parts[1];
  }

  String _getProfit() {
    double profit =
        report.income - report.expense - report.pendingBal - report.driverSal;
    return formatNumber(profit);
  }
}
