import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';

class Expense {
  FirebaseFirestore fireStore;
  CallContext callContext;

  Expense() {
    fireStore = FirebaseFirestore.instance;
    callContext = CallContext();
  }

  void addExpense(ModelExpense expense, String companyId) async {
    fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .add({
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
        .then(callContext.setSuccess('expense added'))
        .catchError((error) => callContext.setError("$error"));

    if (callContext.isError) {
      print(callContext.errorMessage);
      return null;
    } else
      print(callContext.message);
  }

  Future<void> updateExpense(
      ModelExpense expense, String companyId, String docid) {
    final snapShot = fireStore
        .collection(Constants.COMPANIES)
        .doc(companyId)
        .collection(Constants.EXPENSE)
        .doc(docid);
    if (snapShot == null) {
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
}
