import 'package:cloud_firestore/cloud_firestore.dart';

class ModelTrip {
  ModelTrip(
      {this.id,
      this.startDate,
      this.endDate,
      this.startReading,
      this.endReading,
      this.distance,
      this.billAmount,
      this.paidAmount,
      this.balanceAmount,
      this.driverSalary,
      this.customerName,
      this.tripNo,
      this.vehicleRegNo,
      this.driverName,
      this.driverUid,
      this.startingFrom,
      this.destination,
      this.status,
      this.isRoundTrip,
      this.customerPhone});
  String id;
  String driverName;
  String driverUid;
  Timestamp startDate;
  Timestamp endDate;
  // Timestamp timestamp; //same as startdate
  int startReading;
  int endReading;
  int distance;
  double billAmount;
  double paidAmount;
  double balanceAmount;
  double driverSalary;
  String customerName;
  String customerPhone;
  String tripNo;
  String vehicleRegNo;
  String startingFrom;
  String destination;
  String status;
  bool isRoundTrip = false;

  Map<String, Object> toJson() {
    return <String, Object>{
      'StartDate': startDate,
      'EndDate': endDate,
      'StartReading': startReading,
      'EndReading': endReading,
      'Distance': distance,
      'BillAmount': billAmount,
      'PaidAmount': paidAmount,
      'BalanceAmount': balanceAmount,
      'DriverSalary': driverSalary,
      'CustomerName': customerName,
      'TripNo': tripNo,
      'VehicleRegNo': vehicleRegNo,
      'StartingFrom': startingFrom,
      'Destination': destination,
      'DriverName': driverName,
      'DriverUid': driverUid,
      'Status': status,
      'IsRoundTrip': isRoundTrip,
      'CustomerPhone': customerPhone,
    };
  }

  static ModelTrip fromDoc(DocumentSnapshot<Object> doc) {
    final Map<String, Object> json = doc.data() as Map<String, Object>;

    return ModelTrip(
      id: doc.id,
      balanceAmount: json['BalanceAmount'] as double,
      billAmount: json['BillAmount'] as double,
      customerName: (json['CustomerName'] ?? '') as String,
      destination: (json['Destination'] ?? '') as String,
      distance: json['Distance'] as int,
      driverName: (json['DriverName'] ?? '') as String,
      driverSalary: json['DriverSalary'] as double,
      driverUid: (json['DriverUid'] ?? '') as String,
      endDate: json['EndDate'] as Timestamp,
      endReading: json['EndReading'] as int,
      paidAmount: json['PaidAmount'] as double,
      startDate: json['StartDate'] as Timestamp,
      startReading: json['StartReading'] as int,
      startingFrom: (json['StartingFrom'] ?? '') as String,
      tripNo: (json['TripNo'] ?? '') as String,
      vehicleRegNo: (json['VehicleRegNo'] ?? '') as String,
      status: (json['Status'] ?? '') as String,
      isRoundTrip: (json['IsRoundTrip'] ?? false) as bool,
      customerPhone: (json['CustomerPhone'] ?? '') as String,
    );
  }

  static List<ModelTrip> fromDocs(QuerySnapshot<Object> snapshot) {
    final List<ModelTrip> trips = <ModelTrip>[];
    for (final QueryDocumentSnapshot<Object> doc in snapshot?.docs) {
      trips.add(fromDoc(doc));
    }
    return trips;
  }
}
