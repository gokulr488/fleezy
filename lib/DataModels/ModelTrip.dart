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
  String startingFrom;
  String destination;

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
      this.driverUid,
      this.startingFrom,
      this.destination});

  static Map<String, dynamic> getDocOf(ModelTrip trip) {
    return {
      'StartDate': trip.startDate,
      'EndDate': trip.endDate,
      'Timestamp': trip.timestamp,
      'StartReading': trip.startReading,
      'EndReading': trip.endReading,
      'Distance': trip.distance,
      'BillAmount': trip.billAmount,
      'PaidAmount': trip.paidAmount,
      'BalanceAmount': trip.balanceAmount,
      'DriverSalary': trip.driverSalary,
      'CustomerName': trip.customerName,
      'TripNo': trip.tripNo,
      'VehicleRegNo': trip.vehicleRegNo,
      'StartingFrom': trip.startingFrom,
      'Destination': trip.destination,
      'DriverName': trip.driverName,
      'DriverUid': trip.driverUid
    };
  }

  static ModelTrip getTripFromDoc(DocumentSnapshot doc) {
    Map data = doc.data();

    return ModelTrip(
      //driverUid: doc.id,
      balanceAmount: data['BalanceAmount'] ?? '',
      billAmount: data['BillAmount'] ?? '',
      customerName: data['CustomerName'] ?? '',
      destination: data['Destination'] ?? '',
      distance: data['Distance'] ?? '',
      driverName: data['DriverName'] ?? '',
      driverSalary: data['DriverSalary'] ?? '',
      driverUid: data['DriverUid'] ?? '',
      endDate: data['EndDate'] ?? '',
      endReading: data['EndReading'] ?? '',
      paidAmount: data['PaidAmount'] ?? '',
      startDate: data['StartDate'] ?? '',
      startReading: data['StartReading'] ?? '',
      startingFrom: data['StartingFrom'] ?? '',
      timestamp: data['Timestamp'] ?? '',
      tripNo: data['TripNo'] ?? '',
      vehicleRegNo: data['VehicleRegNo'] ?? '',
    );
  }
}
