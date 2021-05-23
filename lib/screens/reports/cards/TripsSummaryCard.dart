import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';

class TripSummaryCard extends StatelessWidget {
  final ModelReport report;

  const TripSummaryCard({@required this.report});
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
            DataRowWidget(
                field: 'Total Trips', value: formatInt(report.totalTrips)),
            DataRowWidget(
                field: 'Payment Pending Trips',
                value: formatInt(report.pendingPayTrips)),
            DataRowWidget(
                field: 'Cancelled Trips',
                value: formatInt(report.cancelledTrips)),
            DataRowWidget(
                field: 'Kms Travelled',
                value: formatDouble(report.kmsTravelled)),
          ],
        ),
      ),
    );
  }
}
