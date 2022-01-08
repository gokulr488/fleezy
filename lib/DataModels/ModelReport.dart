import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ModelReport {
  ModelReport({
    this.reportId,
    this.income = 0,
    this.pendingBal = 0,
    this.driverSal = 0,
    this.expense = 0,
    this.totalTrips = 0,
    this.pendingPayTrips = 0,
    this.cancelledTrips = 0,
    this.kmsTravelled = 0,
    this.fuelCost = 0,
    this.ltrs = 0,
    this.serviceCost = 0,
    this.repairCost = 0,
    this.spareCost = 0,
    this.noOfService = 0,
    this.noOfFines = 0,
    this.fineCost = 0,
    this.taxInsuranceCost = 0,
    this.otherCost = 0,
    this.fastagCost = 0,
  });

  @Id()
  int id;
  String reportId;
  double income;
  double pendingBal;
  double driverSal;
  double expense;
  int totalTrips;
  int pendingPayTrips;
  int cancelledTrips;
  double kmsTravelled;
  double fuelCost;
  double ltrs;
  double serviceCost;
  double repairCost;
  double spareCost;
  int noOfService;
  int noOfFines;
  double fineCost;
  double taxInsuranceCost;
  double otherCost;
  double fastagCost;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'reportId': reportId,
      'income': income,
      'pendingBal': pendingBal,
      'driverSal': driverSal,
      'expense': expense,
      'totalTrips': totalTrips,
      'pendingPayTrips': pendingPayTrips,
      'cancelledTrips': cancelledTrips,
      'kmsTravelled': kmsTravelled,
      'fuelCost': fuelCost,
      'ltrs': ltrs,
      'serviceCost': serviceCost,
      'repairCost': repairCost,
      'spareCost': spareCost,
      'noOfService': noOfService,
      'noOfFines': noOfFines,
      'fineCost': fineCost,
      'otherCost': otherCost,
      'taxInsuranceCost': taxInsuranceCost,
      'fastagCost': fastagCost,
    };
  }

  static ModelReport fromDoc(DocumentSnapshot<Object> doc) {
    final Map<String, Object> json = doc.data() as Map<String, Object>;

    return ModelReport(
      reportId: (json['reportId'] ?? '') as String,
      income: (json['income'] as num) + .0 ?? 0.0,
      pendingBal: (json['pendingBal'] as num) + .0 ?? 0.0,
      driverSal: (json['driverSal'] as num) + .0 ?? 0.0,
      expense: (json['expense'] ?? 0) as double,
      totalTrips: (json['totalTrips'] ?? 0) as int,
      pendingPayTrips: (json['pendingPayTrips'] ?? 0) as int,
      cancelledTrips: (json['cancelledTrips'] ?? 0) as int,
      kmsTravelled: (json['kmsTravelled'] ?? 0) as double,
      fuelCost: (json['fuelCost'] ?? 0) as double,
      ltrs: (json['ltrs'] ?? 0) as double,
      serviceCost: (json['serviceCost'] ?? 0) as double,
      repairCost: (json['repairCost'] ?? 0) as double,
      spareCost: (json['spareCost'] ?? 0) as double,
      noOfService: (json['noOfService'] ?? 0) as int,
      noOfFines: (json['noOfFines'] ?? 0) as int,
      fineCost: (json['fineCost'] ?? 0) as double,
      otherCost: (json['otherCost'] ?? 0) as double,
      taxInsuranceCost: (json['taxInsuranceCost'] ?? 0) as double,
      fastagCost: (json['fastagCost'] ?? 0) as double,
    );
  }

  static List<ModelReport> fromDocs(QuerySnapshot<Object> snapshot) {
    final List<ModelReport> reports = [];
    for (final DocumentSnapshot<Object> doc in snapshot.docs) {
      reports.add(fromDoc(doc));
    }
    return reports;
  }

  static ModelReport firstFromDoc(QuerySnapshot<Object> snapshot) {
    final DocumentSnapshot<Object> doc = snapshot.docs.first;
    return fromDoc(doc);
  }
}
