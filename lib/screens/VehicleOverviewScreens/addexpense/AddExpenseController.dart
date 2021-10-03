import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/Validator.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataAccess/ExpenseApis.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/services/FirebaseStorageService.dart';
import 'package:fleezy/services/ImageService.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddExpenseController {
  AddExpenseController() {
    expenseDo = ModelExpense();
  }
  ModelExpense expenseDo;
  ModelVehicle vehicleDo;
  bool validateOdoMeter = true;
  UploadTask uploadTask;

  File photo;

  Future<bool> onAddExpense(BuildContext context, String regNumber) async {
    if (vehicleDo == null) {
      final CallContext callContext =
          await Vehicle().getVehicleByRegNo(regNumber);
      vehicleDo = callContext.data as ModelVehicle;
    }
    if (_valid(context)) {
      showSendingDialogue(context);
      await _uploadPhoto(context);
      _enrichExpenseDo(context);
      final CallContext callContext =
          await ExpenseApis().addNewExpense(expenseDo, vehicleDo, context);
      Navigator.pop(context);
      if (callContext.isError) {
        showErrorAlert(
            context, 'Failed to Add Expense.${callContext.errorMessage}');
      } else {
        Navigator.pop(context);
        showSubmitResponse(context, 'Expense Added');
        return true;
      }
    }
    return false;
  }

  bool _valid(BuildContext context) {
    final Validator validate = Validator();
    try {
      validate.fileObject(photo, 'Expense Bill photo not added', context);
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
    final AppData appData = Provider.of<AppData>(context, listen: false);
    final ModelUser user = appData.user;
    expenseDo.driverName = user.fullName ?? user.phoneNumber;
    expenseDo.vehicleRegNo = vehicleDo.registrationNo;
    expenseDo.tripNo = appData.trip?.id;
    expenseDo.timestamp = Timestamp.now();
  }

  Future<void> takePhoto() async {
    photo = await ImageService().getImage();
  }

  Future<void> _uploadPhoto(BuildContext context) async {
    if (photo != null) {
      final String filePath =
          Constants.FUEL_BILLS_FOLDER + basename(photo.path);
      uploadTask = FirebaseStorageService.uploadFile(filePath, photo);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      final String urlDownload = await snapshot.ref.getDownloadURL();
      expenseDo.imagePath = urlDownload;
      debugPrint('Download-Link: $urlDownload');
    } else {
      showErrorAlert(context, 'Expense photo not uploaded');
    }
  }
}
