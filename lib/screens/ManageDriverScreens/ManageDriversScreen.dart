import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/DriverCard.dart';
import 'package:fleezy/screens/ManageDriverScreens/AddDriverScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageDriversScreen extends StatelessWidget {
  static const String id = 'ManageDriversScreen';
  @override
  Widget build(BuildContext context) {
    _getDrivers(context);
    return BaseScreen(
      headerText: 'Manage Drivers',
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Consumer<AppData>(builder: (context, appData, _) {
              List<DriverCard> driverCards = [];
              for (ModelUser driver in appData.drivers ?? []) {
                driverCards.add(buildDriverCard(driver));
              }
              return ScrollableList(childrenHeight: 120, items: driverCards);
            }),
          )),
          RoundedButton(
              title: 'Add New Driver',
              onPressed: () {
                Navigator.pushNamed(context, AddDriverScreen.id);
              })
        ],
      ),
    );
  }

  void _getDrivers(BuildContext context) async {
    AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData.drivers == null) {
      List<ModelUser> drivers =
          await Roles().getAllUsersInCompany(appData.user.companyId);
      appData.setDrivers(drivers);
    }
  }

  DriverCard buildDriverCard(ModelUser driver) {
    return DriverCard(
      user: driver,
    );
  }
}
