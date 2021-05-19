import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';
import 'package:flutter/material.dart';

class PendingBalanceCard extends StatelessWidget {
  final ModelTrip trip;

  const PendingBalanceCard({@required this.trip});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 8,
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DataRowWidget(
              field: 'Party',
              value: trip.customerName ?? '',
              fontSize: 18,
            ),
            DataRowWidget(
              field: 'Pending Balance',
              value: trip.balanceAmount.toString(),
              color: Colors.red[500],
              fontSize: 18,
            ),
            DataRowWidget(
              field: 'Driver',
              value: trip.driverName ?? '',
              fontSize: 18,
            ),
            DataRowWidget(
              field: 'Vehicle',
              value: trip.vehicleRegNo,
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
