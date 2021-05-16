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
      padding: const EdgeInsets.all(10),
      child: DropDownButton(
          icon: Icons.calendar_today,
          hintText: 'Year',
          value: DateFormat('yyyy').format(repData.selectedYear),
          values: getYears(),
          onChanged: (String value) {}),
    );
  }
}
// TODO make date range selection work across screens
// date range should update in reports screen and filter sheet
