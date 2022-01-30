import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/DataModels/Quarters.dart';
import 'package:fleezy/DataModels/ReportType.dart';
import 'package:fleezy/components/DropDownButton.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TimePeriodSelector extends StatelessWidget {
  final ReportsController ctrl = ReportsController();
  @override
  Widget build(BuildContext context) {
    final ReportData repData = Provider.of<ReportData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DropDownButton(
          icon: Icons.calendar_today,
          hintText: getHint(repData),
          value: getDefaultValue(repData),
          values: ctrl.getFilterValues(repData),
          onChanged: (String value) {
            if (repData.filterPeriod == ReportType.MONTHLY) {
              repData.setSelectedMonth(value);
            } else {
              //repData.setselq
            }
          }),
    );
  }

  String getHint(ReportData repData) {
    return repData.filterPeriod.getString();
  }

  String getDefaultValue(ReportData repData) {
    if (repData.filterPeriod == ReportType.MONTHLY) {
      final DateTime now = DateTime.now();
      final String month = DateFormat('MMM').format(now);
      return month;
    }

    if (repData.filterPeriod == ReportType.QUARTERLY) {
      return Quarter.Jan_Mar.getString();
    }
    return '';
  }
}
