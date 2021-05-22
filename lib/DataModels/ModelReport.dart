import 'package:cloud_firestore/cloud_firestore.dart';

class ModelReport {
  String reportId;
  double income;
  double pendingBal;
  double expense;
  double totalTrips;
  double pendingPayTrips;
  double cancelledTrips;
  double kmsTravelled;
  double fuelCost;
  double ltrs;
  double serviceCost;
  double repairCost;
  double spareCost;
  double noOfService;
  double noOfFines;
  double fineCost;
  double otherCost;

  ModelReport(
      {this.reportId,
      this.income,
      this.pendingBal,
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

  static ModelReport getCompanyFromDoc(DocumentSnapshot doc) {
    Map data = doc.data();

    return ModelReport(
      reportId: data['reportId'] ?? '',
      income: data['income'] ?? 0,
      pendingBal: data['pendingBal'] ?? 0,
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

  static List<ModelReport> getCompanyFrom(QuerySnapshot snapshot) {
    List<ModelReport> users = [];
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      users.add(getCompanyFromDoc(doc));
    }
    return users;
  }

  static ModelReport getUserFromSnapshot(QuerySnapshot snapshot) {
    QueryDocumentSnapshot doc = snapshot.docs.first;
    return getCompanyFromDoc(doc);
  }
}
