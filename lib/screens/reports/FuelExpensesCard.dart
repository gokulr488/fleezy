import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class FuelExpensesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Fuel Expenses',
                style: TextStyle(fontSize: 20, color: kHighlightColour)),
            DataRowWidget(
              field: 'Total Fuel Cost',
              value: '40,000,00 Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(field: 'Litres Filled', value: '4,444 Litres'),
            DataRowWidget(field: 'Average Fuel Price', value: '90 Rs/L'),
            DataRowWidget(field: 'Average Mileage', value: '1.8 Km/L'),
            DataRowWidget(field: 'Cost per Km', value: '5 Rs/Km'),
          ],
        ),
      ),
    );
  }
}
