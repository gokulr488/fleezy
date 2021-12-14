import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

import '../../Common/UiConstants.dart';

const TextStyle _kLabelTS = TextStyle(fontSize: 18, color: kTextColor);

class PaymentDetailsCard extends StatelessWidget {
  const PaymentDetailsCard({@required this.trip});
  final ModelTrip trip;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: (trip.status != Constants.CANCELLED) ? 175 : 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (trip.status != Constants.CANCELLED)
                    const Text('Total', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    const Text('Paid', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    const Text('Balance', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    const Text('Driver Salary', style: _kLabelTS),
                  const Text('Party Phone No', style: _kLabelTS),
                  Text(Utils.getFormattedTimeStamp(trip.startDate, kTimeFormat),
                      style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    const Text('Round Trip', style: _kLabelTS),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (trip.status != Constants.CANCELLED)
                    Text('${trip.billAmount} Rs', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text('${trip.paidAmount} Rs', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text('${trip.balanceAmount} Rs', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text('${trip.driverSalary} Rs', style: _kLabelTS),
                  Text(trip.customerPhone ?? '', style: _kLabelTS),
                  Text(Utils.getFormattedTimeStamp(trip.endDate, kTimeFormat),
                      style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text(trip.isRoundTrip ? 'YES' : 'NO', style: _kLabelTS),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
