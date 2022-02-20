// ignore_for_file: avoid_print

import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/main.dart';
import 'package:fleezy/objectbox.g.dart';

class ReportBox {
  final Box<ModelReport> _box = objectbox.reportsBox;

  void put(ModelReport vehicleReport) {
    // if duplicate entry exception is occuring, get report by report ID and update ID before inserting so that doc gets updated
    _box.put(vehicleReport);
  }

  void deleteByReportId(String reportId) {
    ModelReport report = getByReportId(reportId);
    if (report != null) _box.remove(report.id);
  }

  ModelReport getByReportId(String reportId) {
    Query<ModelReport> query =
        _box.query(ModelReport_.reportId.equals(reportId)).build();
    return query.findFirst();
  }

  List<ModelReport> getReportsIn({String month, int year}) {
    Query<ModelReport> query = _box
        .query(ModelReport_.year.equals(year) &
            ModelReport_.month.equals(month)) //try with contains in reportId
        .build();
    return query.find();
  }

  void deleteAll() {
    print('Deleting All Reports from Local DB');
    _box.removeAll();
  }
}


// Query<User> query = userBox.query(
//     User_.firstName.equals('Joe') &
//     User_.yearOfBirth.greaterThan(1970) &
//     User_.lastName.startsWith('O')).build();
// List<User> youngJoes = query.find();