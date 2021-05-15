import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class FinesOtherExpensesCard extends StatelessWidget {
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
              field: 'Total Fines',
              value: '3,000 Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(field: 'No Of Fines', value: '2'),
            DataRowWidget(
              field: 'Other Expenses',
              value: '7,000 Rs',
              color: Colors.red[500],
            )
          ],
        ),
      ),
    );
  }
}
