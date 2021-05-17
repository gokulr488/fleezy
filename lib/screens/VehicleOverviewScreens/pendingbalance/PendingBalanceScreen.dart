import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DatePicker.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingBalanceScreen extends StatelessWidget {
  static const String id = 'PendingBalanceScreen';
  @override
  Widget build(BuildContext context) {
    String regNumber = ModalRoute.of(context).settings.arguments as String;
    AppData appdata = Provider.of<AppData>(context, listen: false);
    return BaseScreen(
      headerText: 'Pending Balances',
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IgnorePointer(
          child: VehicleCard(
            registrationNumber: regNumber,
            currentDriver: appdata.user.fullName ?? appdata.user.phoneNumber,
          ),
        ),
        DatePicker(
            text: 'Filter',
            onTap: () async {
              // onFilterClicked(context, appdata, regNumber);
            }),
        Expanded(
          child: Consumer<AppData>(builder: (context, misData, _) {
            return ScrollableList(childrenHeight: 100, items: []);
          }),
        ),
        RoundedButton(
          title: 'Refresh',
          onPressed: () => {},
        )
      ]),
    );
  }
}
