import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDownButton.dart';
import 'package:fleezy/components/HorLine.dart';
import 'package:fleezy/screens/reports/cards/FinesOtherExpenseCard.dart';
import 'package:fleezy/screens/reports/cards/FuelExpensesCard.dart';
import 'package:fleezy/screens/reports/cards/ServiceRepairCard.dart';
import 'package:fleezy/screens/reports/cards/SummaryReportCard.dart';
import 'package:fleezy/screens/reports/cards/TripsSummaryCard.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  static const String id = 'ReportsScreen';
  @override
  Widget build(BuildContext context) {
    List<String> expenses = ['All', 'Fuel', 'June'];
    expenses.addAll(Constants.EXPENSE_TYPES);
    return BaseScreen(
      headerText: 'Reports',
      child: SingleChildScrollView(
        child: Column(
          children: [
            _FilterWidget(),
            SummaryReportCard(),
            TripSummaryCard(),
            Text(
              'Expenses',
              style: TextStyle(fontSize: 20, color: Colors.red[500]),
            ),
            HorLine(),
            FuelExpensesCard(),
            ServiceRepairCard(),
            FinesOtherExpensesCard(),
          ],
        ),
      ),
    );
  }
}

class _FilterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 40,
          child: DropDownButton(
              icon: Icons.calendar_today,
              hintText: 'Month',
              defaultValue: 'May',
              values: ['April', 'May', 'June'],
              onChanged: (String value) {}),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 40,
          child: DropDownButton(
              icon: Icons.drive_eta_rounded,
              hintText: 'Vehicle',
              defaultValue: 'All',
              values: ['All', 'May', 'June'],
              onChanged: (String value) {}),
        ),
        IconButton(icon: Icon(Icons.filter_list), onPressed: () {}),
      ],
    );
  }
}
