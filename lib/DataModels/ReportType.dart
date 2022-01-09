enum ReportType {
  VEHICLE_MONTHLY,
  VEHICLE_QUARTERLY,
  VEHICLE_YEARLY,
  MONTHLY,
  QUARTERLY,
  YEARLY
}

extension ParseToString on ReportType {
  String getString() {
    return toString().split('.').last;
  }
}
// combined monthly report => MAY-2021
// vehicle monthly report  => KL-01-BQ-4086_MAY-2021

//combined Quarterly report=> JAN-MAR-2021
//vehicle Quarterly report=> KL-01-BQ-4086_JAN-MAR-2021

//combined yearly report  => 2021
//vehicle yearly report   =>KL-01-BQ-4086_2021