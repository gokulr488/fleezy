import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
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
                field: 'Total Trips',
                value: Utils.formatInt(report.totalTrips)),
            DataRowWidget(
                field: 'Payment Pending Trips',
                value: Utils.formatInt(report.pendingPayTrips)),
            DataRowWidget(
                field: 'Cancelled Trips',
                value: Utils.formatInt(report.cancelledTrips)),
            DataRowWidget(
                field: 'Kms Travelled',
                value: Utils.formatDouble(report.kmsTravelled)),
          ],
        ),
      ),
    );
  }
}
