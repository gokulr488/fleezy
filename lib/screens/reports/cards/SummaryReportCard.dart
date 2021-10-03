import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class SummaryReportCard extends StatelessWidget {
  const SummaryReportCard({@required this.report});

  final ModelReport report;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Text('Summary', style: kReportCardHeaderTS),
            DataRowWidget(
              field: 'Income',
              value: '${Utils.formatDouble(report.income)} Rs',
              color: Colors.green[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Pending Balances',
              value: '${Utils.formatDouble(report.pendingBal)} Rs',
              color: Colors.red[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Driver Salary',
              value: '${Utils.formatDouble(report.driverSal)} Rs',
              color: Colors.red[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Expenses',
              value: '${Utils.formatDouble(report.expense)} Rs',
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
    final double profit =
        report.income - report.expense - report.pendingBal - report.driverSal;
    return Utils.formatDouble(profit);
  }
}
