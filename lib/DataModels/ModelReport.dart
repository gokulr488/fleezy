import 'package:cloud_firestore/cloud_firestore.dart';

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
  });

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

  static Map<String, dynamic> getDocOf(ModelReport report) {
    return <String, dynamic>{
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
      'taxInsuranceCost': report.taxInsuranceCost,
    };
  }

  static ModelReport getReportFromDoc(DocumentSnapshot doc) {
    final Map data = doc.data();

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
      taxInsuranceCost: data['taxInsuranceCost'] ?? 0,
    );
  }

  static List<ModelReport> getReportFrom(QuerySnapshot snapshot) {
    final List<ModelReport> reports = <ModelReport>[];
    for (final DocumentSnapshot doc in snapshot.docs) {
      reports.add(getReportFromDoc(doc));
    }
    return reports;
  }

  static ModelReport getReportFromSnapshot(QuerySnapshot snapshot) {
    final DocumentSnapshot doc = snapshot.docs.first;
    return getReportFromDoc(doc);
  }
}
