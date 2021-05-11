import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DatePicker.dart';
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
    String regNumber = ModalRoute.of(context).settings.arguments as String;
    AppData appdata = Provider.of<AppData>(context, listen: false);
    getData(regNumber, context, appdata);
    return BaseScreen(
        headerText: 'Trip History',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IgnorePointer(
                child: VehicleCard(
                  registrationNumber: regNumber,
                  currentDriver:
                      appdata.user.fullName ?? appdata.user.phoneNumber,
                ),
              ),
              DatePicker(
                  text: '${Utils.getFormattedTimeStamp(date)}',
                  onTap: () async {
                    date = Utils.getTimeStamp(await Utils.pickDate(context));

                    // setState(() {});
                  }),
              Expanded(
                child: Consumer<AppData>(builder: (context, misData, _) {
                  return ScrollableList(
                      childrenHeight: 100, items: tripDetailCards);
                }),
              ),
              RoundedButton(
                  title: 'Refresh',
                  onPressed: () =>
                      onRefreshPressed(context, regNumber, appdata))
            ]));
  }
}
