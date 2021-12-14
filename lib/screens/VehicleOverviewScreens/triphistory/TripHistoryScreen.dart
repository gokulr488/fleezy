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
    final String regNumber =
        ModalRoute.of(context).settings.arguments as String;
    final AppData appdata = Provider.of<AppData>(context, listen: false);
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
                  }),
              Expanded(
                // ignore: lines_longer_than_80_chars
                child: Consumer<AppData>(
                    builder: (BuildContext context, AppData appData, _) {
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

  Future<void> onFilterClicked(
      BuildContext context, AppData appData, String regNumber) async {
    ctrl.from = DateTime.now();
    ctrl.to = DateTime.now();
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return TripFilterSheet(
              ctrl: ctrl, appData: appData, regNumber: regNumber);
        });
  }
}
