import 'package:fleezy/Common/ReportData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ReportType.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/screens/reports/ReportsController.dart';
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
  final ReportsController ctrl = ReportsController();
  @override
  Widget build(BuildContext context) {
    final ReportData repData = Provider.of<ReportData>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text('Report Filters', style: TextStyle(fontSize: 18)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(repData, ReportType.MONTHLY),
                _buildButton(repData, ReportType.QUARTERLY),
                _buildButton(repData, ReportType.YEARLY),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(child: YearSelector()),
              if (repData.filterPeriod != ReportType.YEARLY)
                Expanded(child: TimePeriodSelector()),
            ],
          ),
          const HorLine(),
          if (repData.filterPeriod == ReportType.MONTHLY)
            RoundedButton(
                onPressed: () => ctrl.onBuildReportPressed(context),
                title: 'Build Report in server',
                width: MediaQuery.of(context).size.width * 0.27,
                colour: Colors.grey,
                elevation: 1),
          RoundedButton(
              onPressed: () => ctrl.deleteAllReports(),
              title: 'Delete local reports',
              width: MediaQuery.of(context).size.width * 0.27,
              colour: Colors.red,
              elevation: 1),
          const Spacer(),
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

  RoundedButton _buildButton(ReportData repData, ReportType period) {
    return RoundedButton(
      onPressed: () {
        repData.filterPeriod = period;
        setState(() {});
      },
      title: period.getString(),
      width: MediaQuery.of(context).size.width * 0.27,
      colour: repData.filterPeriod == period ? kHighlightColour : null,
      elevation: 4,
    );
  }
}
