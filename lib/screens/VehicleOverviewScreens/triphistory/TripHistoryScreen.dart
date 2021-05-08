import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripHistoryScreen extends StatelessWidget {
  static const String id = 'TripHistoryScreen';
  @override
  Widget build(BuildContext context) {
    TripHistoryController ctrl = TripHistoryController();
    String regNumber = ModalRoute.of(context).settings.arguments as String;
    AppData appdata = Provider.of<AppData>(context, listen: false);
    return BaseScreen(
        headerText: 'Trip History',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VehicleCard(
                registrationNumber: regNumber,
                currentDriver:
                    appdata.user.fullName ?? appdata.user.phoneNumber,
              ),
              SizedBox(height: 15),
              Expanded(child: ScrollableList(childrenHeight: 90, items: [])),
              RoundedButton(
                  title: 'Refresh',
                  onPressed: () => ctrl.onRefreshPressed(context, regNumber))
            ]));
  }
}
