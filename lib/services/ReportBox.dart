import 'package:fleezy/DataModels/ModelReport.dart';
import 'package:fleezy/main.dart';
import 'package:fleezy/objectbox.g.dart';

class ReportBox {
  final Box<ModelReport> _box = objectbox.reportsBox;

  void put(ModelReport vehicleReport) {
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
}


// Query<User> query = userBox.query(
//     User_.firstName.equals('Joe') &
//     User_.yearOfBirth.greaterThan(1970) &
//     User_.lastName.startsWith('O')).build();
// List<User> youngJoes = query.find();