import 'package:cloud_firestore/cloud_firestore.dart';

class ModelTrip {
  String driverName;
  String driverUid;
  Timestamp startDate;
  Timestamp endDate;
  Timestamp timestamp; //same as startdate
  int startReading;
  int endReading;
  int distance;
  double billAmount;
  double paidAmount;
  double balanceAmount;
  double driverSalary;
  String customerName;
  String tripNo;
  String vehicleRegNo;

  ModelTrip(
      {this.startDate,
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
      this.timestamp,
      this.driverName,
      this.driverUid});
}
