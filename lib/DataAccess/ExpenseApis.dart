import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
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
    await batch
        .commit()
        .then((value) => callContext.setSuccess('Expense added'))
        .catchError((error) => callContext.setError("$error"));
    return callContext;
  }

  Future<CallContext> getExpensesInTrip(
      ModelTrip trip, BuildContext context) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    QuerySnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(user.companyId)
        .collection(Constants.EXPENSE)
        .where('tripNo', isEqualTo: trip.id)
        .get();
    callContext.data = ModelExpense.getTripsFrom(snapShot);
    return callContext;
  }

  Future<CallContext> filterExpense(BuildContext context, int limit,
      {String regNo, DateTime from, DateTime to}) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    Query reference = fireStore
        .collection(Constants.COMPANIES)
        .doc(user.companyId)
        .collection(Constants.EXPENSE);
    if (regNo != null) {
      reference = reference.where('vehicleRegNo', isEqualTo: regNo);
    }
    if (from != null && to != null) {
      reference = reference.where('timestamp',
          isGreaterThan: Utils.getStartOfDay(from));
      reference =
          reference.where('timestamp', isLessThan: Utils.getEndOfDay(to));
    }

    QuerySnapshot snapShot;
    if (limit == null && from != null && to != null) {
      snapShot = await reference.orderBy('timestamp', descending: true).get();
    } else {
      snapShot = await reference
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();
    }

    callContext.data = ModelExpense.getTripsFrom(snapShot);
    return callContext;
  }
}
