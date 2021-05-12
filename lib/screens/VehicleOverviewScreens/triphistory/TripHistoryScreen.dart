import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DatePicker.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripFilterSheet.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/triphistory/TripHistoryController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripHistoryScreen extends StatefulWidget {
  static const String id = 'TripHistoryScreen';

  @override
  _TripHistoryScreenState createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  TripHistoryController ctrl = TripHistoryController();

  @override
  Widget build(BuildContext context) {
    String regNumber = ModalRoute.of(context).settings.arguments as String;
    AppData appdata = Provider.of<AppData>(context, listen: false);
    ctrl.getData(regNumber, context, appdata);
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
                  text: 'Filter',
                  onTap: () async {
                    onFilterClicked(context, appdata, regNumber);
                    // ctrl.from = await Utils.pickDate(context);
                    // ctrl.onDateSelected(context, regNumber, appdata);
                  }),
              Expanded(
                child: Consumer<AppData>(builder: (context, misData, _) {
                  return ScrollableList(
                      childrenHeight: 100, items: ctrl.tripDetailCards);
                }),
              ),
              RoundedButton(
                  title: 'Refresh',
                  onPressed: () =>
                      ctrl.onRefreshPressed(context, regNumber, appdata))
            ]));
  }

  void onFilterClicked(
      BuildContext context, AppData appData, String regNumber) async {
    await showModalBottomSheet(
        context: context,
        builder: (builder) {
          return TripFilterSheet(
              ctrl: ctrl, appData: appData, regNumber: regNumber);
        });
  }
}
