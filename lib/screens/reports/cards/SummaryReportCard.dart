import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Income',
                    style: TextStyle(fontSize: 20, color: Colors.green[500])),
                Text('Expense',
                    style: TextStyle(fontSize: 20, color: Colors.red[500]))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('1,00,000 Rs',
                    style: TextStyle(fontSize: 20, color: Colors.green[500])),
                Text('60,00,00 Rs',
                    style: TextStyle(fontSize: 20, color: Colors.red[500]))
              ],
            ),
            Text('Profit  40,000 Rs',
                style: TextStyle(fontSize: 20, color: Colors.green[500])),
          ],
        ),
      ),
    );
  }
}
