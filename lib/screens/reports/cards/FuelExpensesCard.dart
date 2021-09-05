import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class FuelExpensesCard extends StatelessWidget {
  final ModelReport report;
  FuelExpensesCard({@required this.report});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 4,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Fuel Expenses', style: kReportCardHeaderTS),
            DataRowWidget(
              field: 'Total Fuel Cost',
              value: Utils.formatDouble(report.fuelCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
                field: 'Litres Filled',
                value: Utils.formatDouble(report.ltrs) + ' Litres'),
            DataRowWidget(
                field: 'Average Fuel Price',
                value: '${_getAvgFuelRate()} Rs/L'),
            DataRowWidget(
                field: 'Average Mileage', value: '${_getAvgMileage()} Km/L'),
            DataRowWidget(
                field: 'Cost per Km', value: '${_getAvgCost()} Rs/Km'),
          ],
        ),
      ),
    );
  }

  String _getAvgFuelRate() {
    try {
      final rate = report.fuelCost / report.ltrs;
      return Utils.formatDouble(rate);
    } catch (e) {
      debugPrint(e);
      return '0.0';
    }
  }

  String _getAvgMileage() {
    try {
      final mileage = report.kmsTravelled / report.ltrs;
      return Utils.formatDouble(mileage);
    } catch (e) {
      debugPrint(e);
      return '0.0';
    }
  }

  String _getAvgCost() {
    try {
      final cost = report.fuelCost / report.kmsTravelled;
      return Utils.formatDouble(cost);
    } catch (e) {
      debugPrint(e);
      return '0.0';
    }
  }
}
