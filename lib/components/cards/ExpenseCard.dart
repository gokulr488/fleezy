import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:flutter/material.dart';

import '../../Common/UiConstants.dart';

const TextStyle _kLabelTS = TextStyle(fontSize: 17, color: kTextColor);

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({this.expense});
  final ModelExpense expense;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      cardChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Type: ${expense.expenseType}', style: _kLabelTS),
                Text('Amount: ${expense.amount}', style: _kLabelTS),
                Text(
                    Utils.getFormattedTimeStamp(
                            expense.timestamp, kDateFormat) ??
                        '',
                    style: _kLabelTS)
              ],
            ),
            if (expense.expenseType == Constants.FUEL)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Litres: ${expense.fuelQty.toStringAsFixed(2)}',
                      style: _kLabelTS),
                  Text('Fuel Price: ${expense.fuelUnitPrice}',
                      style: _kLabelTS),
                  if (expense.isFullTank)
                    const Text('Full Tank', style: _kLabelTS)
                ],
              ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text('Details: ${expense.expenseDetails}',
                    style: _kLabelTS)),
            if (expense.payMode.isNotEmpty)
              Text('Payment Mode: ${expense.payMode}', style: _kLabelTS)
          ],
        ),
      ),
    );
  }
}
