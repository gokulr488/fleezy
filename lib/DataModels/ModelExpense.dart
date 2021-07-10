import 'package:cloud_firestore/cloud_firestore.dart';

class ModelExpense {
  String id;
  String expenseType;
  double amount;
  Timestamp timestamp;
  String tripNo;
  String payMode;
  //Fuel specific
  double fuelUnitPrice;
  double fuelQty;
  bool isFullTank;
  int odometerReading;
  //Insurance Specific
  Timestamp insuranceExpiryDate;
  String policyNumber;
  //Tax specific
  Timestamp taxExpiryDate;
  //driver Specific
  String driverName;
  //Other Expense specific
  String expenseDetails; //provide type=OtherExpense
  String vehicleRegNo; //Doc ID of Model vehicle

  ModelExpense(
      {this.id,
      this.expenseType,
      this.amount,
      this.timestamp,
      this.tripNo,
      this.fuelUnitPrice,
      this.fuelQty,
      this.isFullTank,
      this.insuranceExpiryDate,
      this.policyNumber,
      this.taxExpiryDate,
      this.driverName,
      this.expenseDetails,
      this.vehicleRegNo,
      this.payMode,
      this.odometerReading});

  static Map<String, dynamic> getDocOf(ModelExpense expense) {
    return {
      'expenseType': expense.expenseType,
      'amount': expense.amount,
      'timestamp': expense.timestamp,
      'tripNo': expense.tripNo,
      'payMode': expense.payMode,
      'fuelUnitPrice': expense.fuelUnitPrice,
      'fuelQty': expense.fuelQty,
      'isFullTank': expense.isFullTank,
      'odometerReading': expense.odometerReading,
      'insuranceExpiryDate': expense.insuranceExpiryDate,
      'policyNumber': expense.policyNumber,
      'taxExpiryDate': expense.taxExpiryDate,
      'driverName': expense.driverName,
      'expenseDetails': expense.expenseDetails,
      'vehicleRegNo': expense.vehicleRegNo,
    };
  }

  static ModelExpense getExpenseFromDoc(DocumentSnapshot doc) {
    Map data = doc.data();

    return ModelExpense(
      id: doc.id,
      expenseType: data['expenseType'],
      amount: data['amount'],
      timestamp: data['timestamp'] ?? '',
      tripNo: data['tripNo'] ?? '',
      payMode: data['payMode'] ?? '',
      fuelUnitPrice: data['fuelUnitPrice'],
      fuelQty: data['fuelQty'],
      isFullTank: data['isFullTank'],
      odometerReading: data['odometerReading'] ?? '',
      insuranceExpiryDate: data['insuranceExpiryDate'],
      policyNumber: data['policyNumber'],
      taxExpiryDate: data['taxExpiryDate'],
      driverName: data['driverName'] ?? '',
      expenseDetails: data['expenseDetails'] ?? '',
      vehicleRegNo: data['vehicleRegNo'] ?? '',
    );
  }

  static List<ModelExpense> getTripsFrom(QuerySnapshot snapshot) {
    List<ModelExpense> trips = [];
    for (final doc in snapshot?.docs) {
      trips.add(getExpenseFromDoc(doc));
    }
    return trips;
  }
}
