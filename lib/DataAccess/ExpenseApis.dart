import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseApis {
  FirebaseFirestore fireStore;
  CallContext callContext;
  ExpenseApis() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }

  Future<CallContext> addNewExpense(
      ModelExpense expense, ModelVehicle vehicle, BuildContext context) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    WriteBatch batch = fireStore.batch();
    DocumentReference expenseRef = fireStore
        .collection(Constants.COMPANIES)
        .doc(user.companyId)
        .collection(Constants.EXPENSE)
        .doc();
    expense.id = expenseRef.id;
    batch.set(expenseRef, ModelExpense.getDocOf(expense));

    DocumentReference vehicleRef =
        fireStore.collection(Constants.VEHICLES).doc(vehicle.registrationNo);
    vehicle.latestOdometerReading = expense.odometerReading;
    batch.update(vehicleRef, ModelVehicle.getDocOf(vehicle));
    batch.commit();
    return callContext;
  }
}