import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/components/DropDownButton.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimePeriodSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ReportData repData = Provider.of<ReportData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DropDownButton(
          icon: Icons.calendar_today,
          hintText: getHint(repData),
          value: getDefaultValue(repData),
          values: getFilterValues(repData),
          onChanged: (String value) {}),
    );
  }

  String getHint(ReportData repData) {
    if (repData.filterPeriod == Constants.MONTHLY) return 'Month';
    if (repData.filterPeriod == Constants.QUARTERLY) return 'Quarter';
    if (repData.filterPeriod == Constants.YEARLY) return 'Year';
    return '';
  }

  String getDefaultValue(ReportData repData) {
    if (repData.filterPeriod == Constants.MONTHLY) {
      DateTime now = DateTime.now();
      String month = DateFormat('MMM').format(now);
      return month;
    }

    if (repData.filterPeriod == Constants.QUARTERLY) return Constants.Q1;
    if (repData.filterPeriod == Constants.YEARLY) {
      DateTime now = DateTime.now();
      String year = DateFormat('yyyy').format(now);
      return year;
    }
    return '';
  }
}
