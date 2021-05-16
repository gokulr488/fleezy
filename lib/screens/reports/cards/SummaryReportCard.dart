import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class SummaryReportCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('May 2021 Summary',
                style: TextStyle(fontSize: 22, color: kHighlightColour)),
            DataRowWidget(
              field: 'Income',
              value: '1,00,000 Rs',
              color: Colors.green[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Pending Balances',
              value: '10,000 Rs',
              color: Colors.red[500],
              fontSize: 20,
            ),
            DataRowWidget(
              field: 'Expense',
              value: '60,000 Rs',
              color: Colors.red[500],
              fontSize: 20,
            ),
            Text('Profit  30,000 Rs',
                style: TextStyle(fontSize: 22, color: Colors.green[500])),
          ],
        ),
      ),
    );
  }
}
