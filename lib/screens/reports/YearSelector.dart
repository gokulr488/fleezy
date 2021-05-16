import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/components/DropDownButton.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class YearSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ReportData repData = Provider.of<ReportData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DropDownButton(
          icon: Icons.calendar_today,
          hintText: 'Year',
          defaultValue: DateFormat('yyyy').format(repData.selectedYear),
          values: getYears(),
          onChanged: (String value) {}),
    );
  }
}
