// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelCompany.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Expense {
  Expense() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }
  FirebaseFirestore fireStore;
  CallContext callContext;

  Future<CallContext> addExpense(
      ModelExpense expense, BuildContext context) async {
    final ModelCompany company =
        Provider.of<AppData>(context, listen: false).selectedCompany;
    await fireStore
        .collection(Constants.COMPANIES)
        .doc(company.companyEmail)
        .collection(Constants.EXPENSE)
        .add(expense.toJson())
        .then((dynamic value) => callContext.setSuccess('expense added'))
        .catchError((dynamic error) => callContext.setError('$error'));
    return callContext;
  }

  Future<void> updateExpense(
      ModelExpense expense, String companyId, String docid) async {
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .doc(docid)
        .update(<String, dynamic>{
          'ExpenseType': expense.expenseType,
          'Amount': expense.amount,
          'Timestamp': expense.timestamp,
          'TripNo': expense.tripNo,
          'FuelUnitPrice': expense.fuelUnitPrice,
          'FuelQty': expense.fuelQty,
          'IsFullTank': expense.isFullTank,
          'InsuranceExpiryDate': expense.insuranceExpiryDate,
          'PolicyNumber': expense.policyNumber,
          'TaxExpiryDate': expense.taxExpiryDate,
          'DriverName': expense.driverName,
          'ExpenseName': expense.expenseDetails,
          'VehicleRegNo': expense.vehicleRegNo
        })
        .then((dynamic value) => print('Expense details updated'))
        .catchError(
            (dynamic error) => print('Failed to update expense: $error'));
  }

  Future<void> deleteExpense(String companyId, String docid) async {
    return fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .doc(docid)
        .delete();
  }
}
