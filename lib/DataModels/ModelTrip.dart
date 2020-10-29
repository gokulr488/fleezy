import 'package:cloud_firestore/cloud_firestore.dart';

class ModelTrip {
  final Timestamp startDate;
  final Timestamp endDate;
  final Timestamp timestamp; //same as startdate
  final int startReading;
  final int endReading;
  final int distance;
  final double billAmount;
  final double paidAmount;
  final double balanceAmount;
  final double driverSalary;
  final String customerName;
  final String tripNo;
  final String vehicleRegNo;

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
      this.timestamp});
}
