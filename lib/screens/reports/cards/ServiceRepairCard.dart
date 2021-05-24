import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
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
              value: Utils.formatDouble(report.serviceCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
              field: 'Repair Cost',
              value: Utils.formatDouble(report.repairCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
              field: 'Spares Cost',
              value: Utils.formatDouble(report.spareCost) + ' Rs',
              color: Colors.red[500],
            ),
            DataRowWidget(
                field: 'No Of Services',
                value: Utils.formatInt(report.noOfService)),
          ],
        ),
      ),
    );
  }
}
