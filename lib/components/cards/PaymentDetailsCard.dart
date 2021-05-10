import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

const TextStyle _kLabelTS = TextStyle(fontSize: 17, color: kHighlightColour);

class PaymentDetailsCard extends StatelessWidget {
  final ModelTrip trip;

  const PaymentDetailsCard({@required this.trip});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(Utils.getFormattedTimeTimeStamp(trip.startDate),
                      style: _kLabelTS),
                  Icon(Icons.keyboard_arrow_right_outlined, size: 30),
                  Text(Utils.getFormattedTimeTimeStamp(trip.endDate ?? '-'),
                      style: _kLabelTS)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Bill Amount: ' + trip.billAmount.toString(),
                      style: _kLabelTS),
                  Text('Paid Amount: ' + trip.paidAmount.toString(),
                      style: _kLabelTS)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Balance Amount: ' + trip.balanceAmount.toString(),
                      style: _kLabelTS),
                  Text('Driver Salary: ' + trip.driverSalary.toString(),
                      style: _kLabelTS)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
