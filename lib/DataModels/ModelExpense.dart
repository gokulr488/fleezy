import 'package:cloud_firestore/cloud_firestore.dart';

class ModelExpense {
  final String expenseType;
  final double amount;
  final Timestamp timestamp;
  final String tripNo;
  final String remarks;
  //Fuel specific
  final double fuelUnitPrice;
  final double fuelQty;
  final bool isFullTank;
  //Insurance Specific
  final Timestamp insuranceExpiryDate;
  final String policyNumber;
  //Tax specific
  final Timestamp taxExpiryDate;
  //driver Specific
  final String driverName;
  //Other Expense specific
  final String expenseName; //provide type=OtherExpense
  final String vehicleRegNo; //Doc ID of Model vehicle

  ModelExpense(
      {this.expenseType,
      this.amount,
      this.timestamp,
      this.tripNo,
      this.remarks,
      this.fuelUnitPrice,
      this.fuelQty,
      this.isFullTank,
      this.insuranceExpiryDate,
      this.policyNumber,
      this.taxExpiryDate,
      this.driverName,
      this.expenseName,
      this.vehicleRegNo});
}
