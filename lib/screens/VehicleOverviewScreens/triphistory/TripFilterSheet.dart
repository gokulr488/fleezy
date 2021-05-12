import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/components/DatePicker.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryController.dart';

class TripFilterSheet extends StatefulWidget {
  final TripHistoryController ctrl;
  final String regNumber;
  final AppData appData;

  const TripFilterSheet({@required this.ctrl, this.regNumber, this.appData});
  @override
  _TripFilterSheetState createState() => _TripFilterSheetState();
}

class _TripFilterSheetState extends State<TripFilterSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: DatePicker(
              text:
                  'From : ${Utils.getFormattedDate(widget?.ctrl?.from, kDateFormat) ?? ''} ',
              onTap: () async {
                widget.ctrl.from = await Utils.pickDate(context);
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: DatePicker(
              text:
                  '     To : ${Utils.getFormattedDate(widget?.ctrl?.to, kDateFormat) ?? ''} ',
              onTap: () async {
                widget.ctrl.to = await Utils.pickDate(context);
                setState(() {});
              },
            ),
          ),
          Spacer(flex: 5),
          RoundedButton(
            onPressed: () {
              widget.ctrl
                  .onApplyFilters(context, widget.regNumber, widget.appData);
              Navigator.pop(context);
            },
            title: 'Apply Filters',
          )
        ],
      ),
    );
  }
}
