import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/pendingbalance/PendingBalanceController.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingBalanceScreen extends StatelessWidget {
  final PendingBalanceController ctrl = PendingBalanceController();
  final ScrollController scrollCtrl = ScrollController();

  static const String id = 'PendingBalanceScreen';
  @override
  Widget build(BuildContext context) {
    scrollCtrl.addListener(_scrollListener);
    final String regNumber =
        ModalRoute.of(context).settings.arguments as String;
    final AppData appdata = Provider.of<AppData>(context, listen: false);
    ctrl.getData(regNumber, context, appdata);
    return BaseScreen(
      headerText: 'Pending Balances',
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (regNumber != null)
              IgnorePointer(
                child: VehicleCard(
                  registrationNumber: regNumber,
                  currentDriver:
                      appdata.user.fullName ?? appdata.user.phoneNumber,
                ),
              ),
            Expanded(
              child: Consumer<AppData>(
                  builder: (BuildContext context, AppData appData, _) {
                return ScrollableList(
                    childrenHeight: 160,
                    items: ctrl.pendingBalCards,
                    scrollController: scrollCtrl);
              }),
            ),
            RoundedButton(
              title: 'Refresh',
              onPressed: () =>
                  ctrl.onRefreshPressed(regNumber, context, appdata),
            )
          ]),
    );
  }

  void _scrollListener() {
    if (scrollCtrl.offset >= scrollCtrl.position.maxScrollExtent &&
        !scrollCtrl.position.outOfRange) {
      debugPrint('at the end of list');
      //ctrl.getData();
    }
  }
}
