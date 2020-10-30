import 'package:cloud_firestore/cloud_firestore.dart';

class ModelExpense {
  String expenseType;
  double amount;
  Timestamp timestamp;
  String tripNo;
  String remarks;
  //Fuel specific
  double fuelUnitPrice;
  double fuelQty;
  bool isFullTank;
  //Insurance Specific
  Timestamp insuranceExpiryDate;
  String policyNumber;
  //Tax specific
  Timestamp taxExpiryDate;
  //driver Specific
  String driverName;
  //Other Expense specific
  String expenseName; //provide type=OtherExpense
  String vehicleRegNo; //Doc ID of Model vehicle

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
