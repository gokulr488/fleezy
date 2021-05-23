import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';

class ServiceRepairCard extends StatelessWidget {
  final ModelReport report;

  const ServiceRepairCard({@required this.report});

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
              value: formatDouble(report.serviceCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
              field: 'Repair Cost',
              value: formatDouble(report.repairCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
              field: 'Spares Cost',
              value: formatDouble(report.spareCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
                field: 'No Of Services', value: formatInt(report.noOfService)),
          ],
        ),
      ),
    );
  }
}
