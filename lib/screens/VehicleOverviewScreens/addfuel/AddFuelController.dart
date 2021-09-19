import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';

import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/Validator.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataAccess/ExpenseApis.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/services/ImageService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFuelController {
  StatefulWidget screen;
  ModelExpense expenseDo;
  ModelVehicle vehicleDo;
  TextEditingController litresController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();

  File photo;
  void init() {
    expenseDo = ModelExpense();
    expenseDo.isFullTank = false;
  }

  Future<void> onAddFuel(BuildContext context, String regNumber) async {
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
            context, 'Failed to Add Fuel.' + callContext.errorMessage);
      } else {
        Navigator.pop(context);
        showSubmitResponse(context, 'Fuel Added');
      }
    }
  }

  void calcLitresFilled() {
    if (expenseDo?.fuelUnitPrice != null &&
        expenseDo?.amount != null &&
        expenseDo.fuelUnitPrice > 0 &&
        expenseDo.amount > 0) {
      expenseDo.fuelQty = expenseDo.amount / expenseDo.fuelUnitPrice;
      litresController.text = expenseDo.fuelQty.toStringAsFixed(3);
    }
  }

  void calcTotalPrice() {
    if (expenseDo?.fuelUnitPrice != null &&
        expenseDo?.fuelQty != null &&
        expenseDo.fuelUnitPrice > 0 &&
        expenseDo.fuelQty > 0) {
      expenseDo.amount = (expenseDo.fuelQty * expenseDo.fuelUnitPrice);
      totalPriceController.text = expenseDo.amount.toStringAsFixed(3);
    }
  }

  void dispose() {
    litresController.dispose();
    totalPriceController.dispose();
  }

  bool _valid(BuildContext context) {
    final validate = Validator();
    try {
      validate.stringField(expenseDo.payMode, 'Choose Payment type', context);
      validate.doubleField(expenseDo.amount, 'Enter Total price', context);
      validate.doubleField(
          expenseDo.fuelUnitPrice, 'Enter Fuel Price', context);
      validate.doubleField(expenseDo.fuelQty, 'Enter Fuel Quantity', context);
      validate.odometerReading(expenseDo?.odometerReading,
          vehicleDo?.latestOdometerReading, context);
    } catch (e) {
      return false;
    }
    return true;
  }

  void _enrichExpenseDo(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);
    final user = appData.user;

    expenseDo.driverName = user.fullName ?? user.phoneNumber;
    expenseDo.expenseDetails = 'Fuel Added';
    expenseDo.expenseType = Constants.FUEL;
    expenseDo.vehicleRegNo = vehicleDo.registrationNo;
    expenseDo.tripNo = appData.trip?.id;
    expenseDo.timestamp = Timestamp.now();
  }

  Future<void> takePhoto() async {
    photo = await ImageService().getImage();
  }
}
