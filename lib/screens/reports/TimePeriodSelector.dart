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
              repData.selectedMonth.monthStr = value;
            } else {
              repData.selectedQuarter.quarterStr = value;
            }
          }),
    );
  }

  String getHint(ReportData repData) {
    return repData.filterPeriod.getString();
  }

  String getDefaultValue(ReportData repData) {
    if (repData.filterPeriod == ReportType.MONTHLY) {
      return repData.selectedMonth.monthStr;
    }
    if (repData.filterPeriod == ReportType.QUARTERLY) {
      return repData.selectedQuarter.quarterStr;
    }
    return '';
  }
}
