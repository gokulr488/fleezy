import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Validator.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataAccess/ExpenseApis.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseController {
  ModelExpense expenseDo;
  ModelVehicle vehicleDo;
  bool validateOdoMeter = true;

  AddExpenseController() {
    expenseDo = ModelExpense();
  }

  Future<bool> onAddExpense(BuildContext context, String regNumber) async {
    if (vehicleDo == null) {
      final callContext = await Vehicle().getVehicleByRegNo(regNumber);
      vehicleDo = callContext.data as ModelVehicle;
    }
    if (_valid(context)) {
      _enrichExpenseDo(context);
      showSendingDialogue(context);
      final callContext =
          await ExpenseApis().addNewExpense(expenseDo, vehicleDo, context);
      Navigator.pop(context);
      if (callContext.isError) {
        showErrorAlert(
            context, 'Failed to Add Expense.' + callContext.errorMessage);
      } else {
        Navigator.pop(context);
        showSubmitResponse(context, 'Expense Added');
        return true;
      }
    }
    return false;
  }

  bool _valid(BuildContext context) {
    final validate = Validator();
    try {
      //validate.stringField(expenseDo.payMode, 'Choose Payment type', context);
      validate.stringField(
          expenseDo.expenseType, 'Choose Expense type', context);
      validate.doubleField(expenseDo.amount, 'Enter Amount', context);
      // validate.stringField(
      //     expenseDo.expenseDetails, 'Enter Details of Expense', context);
      if (validateOdoMeter) {
        validate.odometerReading(expenseDo?.odometerReading,
            vehicleDo?.latestOdometerReading, context);
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  void _enrichExpenseDo(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);
    final user = appData.user;
    expenseDo.driverName = user.fullName ?? user.phoneNumber;
    expenseDo.vehicleRegNo = vehicleDo.registrationNo;
    expenseDo.tripNo = appData.trip?.id;
    expenseDo.timestamp = Timestamp.now();
  }
}
