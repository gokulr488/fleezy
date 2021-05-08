import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addexpense/AddExpenseController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  static const String id = 'addExpenseScreen';
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  AddExpenseController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = AddExpenseController();
    ctrl.init();
  }

  @override
  Widget build(BuildContext context) {
    String regNumber = ModalRoute.of(context).settings.arguments as String;
    AppData appdata = Provider.of<AppData>(context, listen: false);
    return BaseScreen(
        headerText: 'Add Expense',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VehicleCard(
                registrationNumber: regNumber,
                currentDriver:
                    appdata.user.fullName ?? appdata.user.phoneNumber,
              ),
              SizedBox(height: 15),
              Expanded(
                  child: ScrollableList(childrenHeight: 90, items: [
                DropDown(
                    defaultValue: ctrl.expenseDo.expenseType,
                    values: Constants.EXPENSE_TYPES,
                    onChanged: (String value) {
                      ctrl.expenseDo.expenseType = value;
                    },
                    hintText: 'Expense Type'),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      ctrl.expenseDo.amount = double.parse(value);
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: 'Amount')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      ctrl.expenseDo.odometerReading = int.parse(value);
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Odometer Reading')),
                TextFormField(
                    minLines: 4,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      ctrl.expenseDo.expenseDetails = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Details of Expense'))
              ])),
              RoundedButton(
                  title: 'Add Expense',
                  onPressed: () => ctrl.onAddExpense(context, regNumber))
            ]));
  }
}
