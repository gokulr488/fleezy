import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class FinesOtherExpensesCard extends StatelessWidget {
  final ModelReport report;
  FinesOtherExpensesCard({@required this.report});

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
                field: 'No Of Fines', value: Utils.formatInt(report.noOfFines)),
            DataRowWidget(
              field: 'Total Fines',
              value: Utils.formatDouble(report.fineCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
              field: 'Other Expenses',
              value: Utils.formatDouble(report.otherCost) + ' Rs',
              color: Colors.red[500],
            )
          ],
        ),
      ),
    );
  }
}
