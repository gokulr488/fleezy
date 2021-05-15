import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class ServiceRepairCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Service, Repairs & Spares',
                style: TextStyle(fontSize: 20, color: kHighlightColour)),
            DataRowWidget(
              field: 'Service Cost',
              value: '3,000 Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
              field: 'Repair Cost',
              value: '5,000 Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
              field: 'Spares Cost',
              value: '2,000 Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(field: 'No Of Services', value: '2'),
          ],
        ),
      ),
    );
  }
}
