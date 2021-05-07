import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Expense {
  FirebaseFirestore fireStore;
  CallContext callContext;

  Expense() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }

  Future<CallContext> addExpense(
      ModelExpense expense, BuildContext context) async {
    ModelUser user = Provider.of<AppData>(context, listen: false).user;
    await fireStore
        .collection(Constants.COMPANIES)
        .doc(user.companyId)
        .collection(Constants.EXPENSE)
        .add(ModelExpense.getDocOf(expense))
        .then((value) => callContext.setSuccess('expense added'))
        .catchError((error) => callContext.setError("$error"));
    return callContext;
  }

  Future<void> updateExpense(
      ModelExpense expense, String companyId, String docid) async {
    DocumentSnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .doc(docid)
        .get();
    if (snapShot.data() == null) {
      print("User not found");
      return null;
    }

    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .doc(docid)
        .update({
          'ExpenseType': expense.expenseType,
          'Amount': expense.amount,
          'Timestamp': expense.timestamp,
          'TripNo': expense.tripNo,
          'Remarks': expense.remarks,
          'FuelUnitPrice': expense.fuelUnitPrice,
          'FuelQty': expense.fuelQty,
          'IsFullTank': expense.isFullTank,
          'InsuranceExpiryDate': expense.insuranceExpiryDate,
          'PolicyNumber': expense.policyNumber,
          'TaxExpiryDate': expense.taxExpiryDate,
          'DriverName': expense.driverName,
          'ExpenseName': expense.expenseName,
          'VehicleRegNo': expense.vehicleRegNo
        })
        .then((value) => print("Expense details updated"))
        .catchError((error) => print("Failed to update expense: $error"));
  }

  Future<void> deleteExpense(String companyId, String docid) async {
    DocumentSnapshot snapShot = await fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .doc(docid)
        .get();
    if (snapShot.data() == null) {
      print("Expense not found");
      return null;
    }
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .doc(docid)
        .delete();
  }
}
