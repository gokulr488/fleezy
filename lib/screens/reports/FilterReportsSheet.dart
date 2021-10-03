import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/reports/TimePeriodSelector.dart';
import 'package:fleezy/screens/reports/YearSelector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterReportsSheet extends StatefulWidget {
  const FilterReportsSheet();
  @override
  _FilterReportsSheetState createState() => _FilterReportsSheetState();
}

class _FilterReportsSheetState extends State<FilterReportsSheet> {
  @override
  Widget build(BuildContext context) {
    final ReportData repData = Provider.of<ReportData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          const Text('Report Filters', style: TextStyle(fontSize: 18)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton(repData, Constants.MONTHLY),
                _buildButton(repData, Constants.QUARTERLY),
                _buildButton(repData, Constants.YEARLY),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(child: YearSelector()),
              if (repData.filterPeriod != Constants.YEARLY)
                Expanded(child: TimePeriodSelector()),
            ],
          ),
          const Spacer(flex: 5),
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
