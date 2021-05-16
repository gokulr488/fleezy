import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/DropDownButton.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilterReportsSheet extends StatefulWidget {
  const FilterReportsSheet();
  @override
  _FilterReportsSheetState createState() => _FilterReportsSheetState();
}

class _FilterReportsSheetState extends State<FilterReportsSheet> {
  @override
  Widget build(BuildContext context) {
    ReportData repData = Provider.of<ReportData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Report Filters', style: TextStyle(fontSize: 18)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(repData, Constants.MONTHLY),
                _buildButton(repData, Constants.QUARTERLY),
                _buildButton(repData, Constants.YEARLY),
              ],
            ),
          ),
          _TimePeriodSelector(),
          Spacer(flex: 5),
          RoundedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            title: 'Apply',
          )
        ],
      ),
    );
  }

  RoundedButton _buildButton(ReportData repData, String period) {
    return RoundedButton(
      onPressed: () {
        repData.setFilterPeriod(period);
        setState(() {});
      },
      title: period,
      width: MediaQuery.of(context).size.width * 0.27,
      colour: repData.filterPeriod == period ? kHighlightColour : null,
      elevation: 4,
    );
  }
}

class _TimePeriodSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ReportData repData = Provider.of<ReportData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: DropDownButton(
            icon: Icons.calendar_today,
            hintText: getHint(repData),
            defaultValue: getDefaultValue(repData),
            values: getFilterValues(repData),
            onChanged: (String value) {}),
      ),
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
