import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  static const String id = 'addExpenseScreen';
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final List<String> expenseTypes = [
    'Vehicle Service',
    'Repair',
    'Spare Parts',
    'Fines'
  ];
  String expenseType = 'Vehicle Service';
  String expenseDetails = '';
  String amount = '';
  String odometerReading = '';
  @override
  Widget build(BuildContext context) {
    VehicleCard vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
        headerText: 'Add Expense',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              vehicle,
              SizedBox(height: 15),
              Expanded(
                  child: ScrollableList(childrenHeight: 90, items: [
                DropDown(
                    defaultValue: expenseType,
                    values: expenseTypes,
                    onChanged: (String value) {
                      expenseType = value;
                    },
                    hintText: 'Expense Type'),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      amount = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: 'Amount')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      odometerReading = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Odometer Reading')),
                TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      expenseDetails = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Details of Expense'))
              ])),
              RoundedButton(
                  title: 'Add Expense', onPressed: () => Navigator.pop(context))
            ]));
  }
}
