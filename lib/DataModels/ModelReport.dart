import 'package:cloud_firestore/cloud_firestore.dart';

class ModelReport {
  String reportId;
  double income = 0;
  double pendingBal = 0;
  double driverSal = 0;
  double expense = 0;
  double totalTrips = 0;
  double pendingPayTrips = 0;
  double cancelledTrips = 0;
  double kmsTravelled = 0;
  double fuelCost = 0;
  double ltrs = 0;
  double serviceCost = 0;
  double repairCost = 0;
  double spareCost = 0;
  double noOfService = 0;
  double noOfFines = 0;
  double fineCost = 0;
  double otherCost = 0;

  ModelReport(
      {this.reportId,
      this.income,
      this.pendingBal,
      this.driverSal,
      this.expense,
      this.totalTrips,
      this.pendingPayTrips,
      this.cancelledTrips,
      this.kmsTravelled,
      this.fuelCost,
      this.ltrs,
      this.serviceCost,
      this.repairCost,
      this.spareCost,
      this.noOfService,
      this.noOfFines,
      this.fineCost,
      this.otherCost});

  static Map<String, dynamic> getDocOf(ModelReport report) {
    return {
      'reportId': report.reportId,
      'income': report.income,
      'pendingBal': report.pendingBal,
      'driverSal': report.driverSal,
      'expense': report.expense,
      'totalTrips': report.totalTrips,
      'pendingPayTrips': report.pendingPayTrips,
      'cancelledTrips': report.cancelledTrips,
      'kmsTravelled': report.kmsTravelled,
      'fuelCost': report.fuelCost,
      'ltrs': report.ltrs,
      'serviceCost': report.serviceCost,
      'repairCost': report.repairCost,
      'spareCost': report.spareCost,
      'noOfService': report.noOfService,
      'noOfFines': report.noOfFines,
      'fineCost': report.fineCost,
      'otherCost': report.otherCost,
    };
  }

  static ModelReport getReportFromDoc(DocumentSnapshot doc) {
    Map data = doc.data();

    return ModelReport(
      reportId: data['reportId'] ?? '',
      income: data['income'] ?? 0,
      pendingBal: data['pendingBal'] ?? 0,
      driverSal: data['driverSal'] ?? 0,
      expense: data['expense'] ?? 0,
      totalTrips: data['totalTrips'] ?? 0,
      pendingPayTrips: data['pendingPayTrips'] ?? 0,
      cancelledTrips: data['cancelledTrips'] ?? 0,
      kmsTravelled: data['kmsTravelled'] ?? 0,
      fuelCost: data['fuelCost'] ?? 0,
      ltrs: data['ltrs'] ?? 0,
      serviceCost: data['serviceCost'] ?? 0,
      repairCost: data['repairCost'] ?? 0,
      spareCost: data['spareCost'] ?? 0,
      noOfService: data['noOfService'] ?? 0,
      noOfFines: data['noOfFines'] ?? 0,
      fineCost: data['fineCost'] ?? 0,
      otherCost: data['otherCost'] ?? 0,
    );
  }

  static List<ModelReport> getReportFrom(QuerySnapshot snapshot) {
    List<ModelReport> users = [];
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      users.add(getReportFromDoc(doc));
    }
    return users;
  }

  static ModelReport getReportFromSnapshot(QuerySnapshot snapshot) {
    QueryDocumentSnapshot doc = snapshot.docs.first;
    return getReportFromDoc(doc);
  }
}
