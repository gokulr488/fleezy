import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class TripSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text('Trips Overview',
                style: TextStyle(fontSize: 20, color: kHighlightColour)),
            DataRowWidget(field: 'Total Trips', value: '2'),
            DataRowWidget(field: 'Cancelled Trips', value: '1'),
            DataRowWidget(field: 'Kms Travelled', value: '8,000 Km'),
          ],
        ),
      ),
    );
  }
}
