import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';

class FinesOtherExpensesCard extends StatelessWidget {
  final ModelReport report;
  final ReportsController ctrl;
  FinesOtherExpensesCard({@required this.report, @required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Fines & Other Expenses',
                style: TextStyle(fontSize: 20, color: kHighlightColour)),
            DataRowWidget(
                field: 'No Of Fines', value: ctrl.formatInt(report.noOfFines)),
            DataRowWidget(
              field: 'Total Fines',
              value: ctrl.formatDouble(report.fineCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
              field: 'Other Expenses',
              value: ctrl.formatDouble(report.otherCost) + ' Rs',
              color: Colors.red[500],
            )
          ],
        ),
      ),
    );
  }
}
