import 'package:cloud_firestore/cloud_firestore.dart';

class ModelTrip {
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
  bool isRoundTrip;

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

  static Map<String, dynamic> getDocOf(ModelTrip trip) {
    return {
      'StartDate': trip.startDate,
      'EndDate': trip.endDate,
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
      'DriverUid': trip.driverUid,
      'Status': trip.status,
      'IsRoundTrip': trip.isRoundTrip,
      'CustomerPhone': trip.customerPhone,
    };
  }

  static ModelTrip getTripFromDoc(DocumentSnapshot doc) {
    Map data = doc.data();

    return ModelTrip(
      id: doc.id,
      balanceAmount: data['BalanceAmount'],
      billAmount: data['BillAmount'],
      customerName: data['CustomerName'] ?? '',
      destination: data['Destination'] ?? '',
      distance: data['Distance'],
      driverName: data['DriverName'] ?? '',
      driverSalary: data['DriverSalary'],
      driverUid: data['DriverUid'] ?? '',
      endDate: data['EndDate'],
      endReading: data['EndReading'],
      paidAmount: data['PaidAmount'],
      startDate: data['StartDate'],
      startReading: data['StartReading'],
      startingFrom: data['StartingFrom'] ?? '',
      tripNo: data['TripNo'] ?? '',
      vehicleRegNo: data['VehicleRegNo'] ?? '',
      status: data['Status'] ?? '',
      isRoundTrip: data['IsRoundTrip'] ?? false,
      customerPhone: data['CustomerPhone'] ?? '',
    );
  }

  static List<ModelTrip> getTripsFrom(QuerySnapshot snapshot) {
    List<ModelTrip> trips = [];
    for (QueryDocumentSnapshot doc in snapshot?.docs) {
      trips.add(getTripFromDoc(doc));
    }
    return trips;
  }
}
