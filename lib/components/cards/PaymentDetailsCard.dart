import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

import '../../Common/UiConstants.dart';

const TextStyle _kLabelTS = TextStyle(fontSize: 18, color: kWhite80);

class PaymentDetailsCard extends StatelessWidget {
  final ModelTrip trip;

  const PaymentDetailsCard({@required this.trip});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: (trip.status != Constants.CANCELLED) ? 175 : 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  if (trip.status != Constants.CANCELLED)
                    Text('Total', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text('Paid', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text('Balance', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text('Driver Salary', style: _kLabelTS),
                  Text('Party Phone No', style: _kLabelTS),
                  Text(Utils.getFormattedTimeStamp(trip.startDate, kTimeFormat),
                      style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text('Round Trip', style: _kLabelTS),
                ],
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              Column(
                children: [
                  if (trip.status != Constants.CANCELLED)
                    Text(trip.billAmount.toString() + ' Rs', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text(trip.paidAmount.toString() + ' Rs', style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text(trip.balanceAmount.toString() + ' Rs',
                        style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text(trip.driverSalary.toString() + ' Rs',
                        style: _kLabelTS),
                  Text(trip.customerPhone ?? '', style: _kLabelTS),
                  Text(Utils.getFormattedTimeStamp(trip.endDate, kTimeFormat),
                      style: _kLabelTS),
                  if (trip.status != Constants.CANCELLED)
                    Text(trip.isRoundTrip ? 'YES' : 'NO', style: _kLabelTS),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
