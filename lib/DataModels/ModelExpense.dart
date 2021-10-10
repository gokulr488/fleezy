import 'package:cloud_firestore/cloud_firestore.dart';

class ModelExpense {
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
      this.odometerReading,
      this.imagePath});

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
  String imagePath;

  Map<String, Object> toJson() {
    return <String, Object>{
      'expenseType': expenseType,
      'amount': amount,
      'timestamp': timestamp,
      'tripNo': tripNo,
      'payMode': payMode,
      'fuelUnitPrice': fuelUnitPrice,
      'fuelQty': fuelQty,
      'isFullTank': isFullTank,
      'odometerReading': odometerReading,
      'insuranceExpiryDate': insuranceExpiryDate,
      'policyNumber': policyNumber,
      'taxExpiryDate': taxExpiryDate,
      'driverName': driverName,
      'expenseDetails': expenseDetails,
      'vehicleRegNo': vehicleRegNo,
      'imagePath': imagePath,
    };
  }

  static ModelExpense fromDoc(DocumentSnapshot<Object> doc) {
    final Map<String, Object> json = doc.data() as Map<String, Object>;

    return ModelExpense(
      id: doc.id,
      expenseType: json['expenseType'] as String,
      amount: json['amount'] as double,
      timestamp: json['timestamp'] as Timestamp,
      tripNo: (json['tripNo'] ?? '') as String,
      payMode: (json['payMode'] ?? '') as String,
      fuelUnitPrice: json['fuelUnitPrice'] as double,
      fuelQty: json['fuelQty'] as double,
      isFullTank: json['isFullTank'] as bool,
      odometerReading: (json['odometerReading'] ?? 0) as int,
      insuranceExpiryDate: json['insuranceExpiryDate'] as Timestamp,
      policyNumber: json['policyNumber'] as String,
      taxExpiryDate: json['taxExpiryDate'] as Timestamp,
      driverName: (json['driverName'] ?? '') as String,
      expenseDetails: (json['expenseDetails'] ?? '') as String,
      vehicleRegNo: (json['vehicleRegNo'] ?? '') as String,
      imagePath: json['imagePath'] as String,
    );
  }

  static List<ModelExpense> fromDocs(QuerySnapshot<Object> snapshot) {
    final List<ModelExpense> trips = <ModelExpense>[];
    for (final DocumentSnapshot<Object> doc in snapshot?.docs) {
      trips.add(fromDoc(doc));
    }
    return trips;
  }
}
