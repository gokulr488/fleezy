import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/DropDownButton.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  static const String id = 'ReportsScreen';
  @override
  Widget build(BuildContext context) {
    List<String> expenses = ['All', 'Fuel', 'June'];
    expenses.addAll(Constants.EXPENSE_TYPES);
    return BaseScreen(
      headerText: 'Reports',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropDownButton(
                    icon: Icons.calendar_today,
                    hintText: 'Month',
                    defaultValue: 'May',
                    values: ['April', 'May', 'June'],
                    onChanged: (String value) {}),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropDownButton(
                    icon: Icons.drive_eta_rounded,
                    hintText: 'Vehicle',
                    defaultValue: 'All',
                    values: ['All', 'May', 'June'],
                    onChanged: (String value) {}),
              ),
              IconButton(icon: Icon(Icons.filter_list), onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
