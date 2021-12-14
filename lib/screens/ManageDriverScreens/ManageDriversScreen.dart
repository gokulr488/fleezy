import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
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
            child: Consumer<AppData>(
                builder: (BuildContext context, AppData appData, _) {
              final List<DriverCard> driverCards = [];
              for (final ModelUser driver in appData.drivers ?? <ModelUser>[]) {
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

  Future<void> _getDrivers(BuildContext context) async {
    final AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData.drivers == null) {
      final List<ModelUser> drivers = await Roles()
          .getAllUsersInCompany(appData.selectedCompany.companyEmail);
      appData.setDrivers(drivers);
    }
  }

  DriverCard buildDriverCard(ModelUser driver) {
    return DriverCard(
      user: driver,
    );
  }
}
