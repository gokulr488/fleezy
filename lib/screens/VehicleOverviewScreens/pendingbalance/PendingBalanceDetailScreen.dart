import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/UiState.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceController.dart';
import 'package:fleezy/screens/reports/DataRowWidget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingBalanceDetailScreen extends StatefulWidget {
  static const String id = 'PendingBalanceDetailScreen';

  @override
  _PendingBalanceDetailScreenState createState() =>
      _PendingBalanceDetailScreenState();
}

class _PendingBalanceDetailScreenState
    extends State<PendingBalanceDetailScreen> {
  final PendingBalanceController ctrl = PendingBalanceController();
  ModelTrip trip;
  String balanceReceived = '';
  bool ignorePending = false;
  @override
  Widget build(BuildContext context) {
    trip = ModalRoute.of(context).settings.arguments as ModelTrip;
    UiState uiState = Provider.of<UiState>(context, listen: false);
    return BaseScreen(
      headerText: 'Balance Details',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  IgnorePointer(child: PendingBalanceCard(trip: trip)),
                  _TripDetailsCard(trip: trip),
                  HorLine(),
                  TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        balanceReceived = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Balance Received')),
                  if (uiState.isAdmin)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Ignore Pending Amount',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: kRedColor)),
                          Checkbox(
                              activeColor: kHighlightColour,
                              value: ignorePending,
                              onChanged: (bool value) {
                                setState(() {
                                  ignorePending = value;
                                });
                              })
                        ]),
                ],
              ),
            ),
          ),
          RoundedButton(
            title: 'Save',
            onPressed: () {
              if (!ctrl.valid(context, trip, balanceReceived, ignorePending)) {
                return;
              }
              if (ignorePending) {
                ctrl.onPendingBalanceSave(context, trip,
                    trip.balanceAmount.toString(), ignorePending);
              } else {
                ctrl.onPendingBalanceSave(
                    context, trip, balanceReceived, ignorePending);
              }
            },
          )
        ],
      ),
    );
  }
}

class _TripDetailsCard extends StatelessWidget {
  const _TripDetailsCard({@required this.trip});

  final ModelTrip trip;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        elevation: 4,
        cardChild: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DataRowWidget(
                field: 'Party Phone No',
                value: trip.customerPhone ?? 'Not available',
                fontSize: 18,
              ),
              DataRowWidget(
                field: 'From',
                value: trip.startingFrom,
                fontSize: 18,
              ),
              DataRowWidget(
                field: 'To',
                value: trip.destination,
                fontSize: 18,
              ),
              DataRowWidget(
                field: 'Total Amount',
                value: trip.billAmount.toString(),
                color: Colors.green[500],
                fontSize: 18,
              ),
              DataRowWidget(
                field: 'Paid Amount',
                value: trip.paidAmount.toString(),
                color: Colors.green[500],
                fontSize: 18,
              ),
              DataRowWidget(
                field: 'Driver Salary',
                value: trip.driverSalary.toString(),
                fontSize: 18,
              ),
            ],
          ),
        ));
  }
}
