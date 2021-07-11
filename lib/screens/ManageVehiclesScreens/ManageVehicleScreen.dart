import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/GridLayout.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/ManageVehicleCard.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/AllowDriversBottomSheet.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/InsurancePaymentScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/TaxPaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageVehicleScreen extends StatelessWidget {
  static const String id = 'manageVehicleScreen';
  @override
  Widget build(BuildContext context) {
    final vehicle =
        ModalRoute.of(context).settings.arguments as ManageVehicleCard;
    return BaseScreen(
        headerText: 'Manage Vehicle',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IgnorePointer(child: vehicle),
              SizedBox(height: 15),
              GridLayout(children: [
                ButtonCard(
                  text: 'Tax Payment',
                  icon: Icons.payment,
                  onTap: () {
                    Navigator.pushNamed(context, TaxPaymentScreen.id,
                        arguments: vehicle);
                  },
                ),
                ButtonCard(
                    text: 'Insurance Payment',
                    icon: Icons.payment,
                    onTap: () {
                      Navigator.pushNamed(context, InsurancePaymentScreen.id,
                          arguments: vehicle);
                    }),
                ButtonCard(
                    text: 'Allowed Drivers',
                    icon: Icons.account_circle,
                    onTap: () {
                      allowedDrivers(context, vehicle.vehicle);
                    }),
                ButtonCard(
                    text: 'Delete Vehicle',
                    icon: Icons.delete,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Alerts(
                                title: 'Delete this vehicle ?',
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('NO')),
                                  TextButton(
                                      onPressed: () async {
                                        final resp = await deleteVehicle(
                                            context, vehicle.vehicle);
                                        Navigator.of(context).pop();
                                        showSubmitResponse(context, resp);
                                      },
                                      child: Text('YES'))
                                ]);
                          });
                    })
              ])
            ]));
  }

  Future<String> deleteVehicle(
      BuildContext context, ModelVehicle vehicle) async {
    showSendingDialogue(context);
    final resp = await Vehicle().deleteVehicle(vehicle);
    Provider.of<AppData>(context, listen: false).deleteVehicle(vehicle);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    return resp;
  }

  void allowedDrivers(BuildContext context, ModelVehicle vehicle) async {
    final appData = Provider.of<AppData>(context, listen: false);
    if (appData.drivers == null) {
      final drivers =
          await Roles().getAllUsersInCompany(appData.user.companyId);
      appData.setDrivers(drivers);
    }
    final allowedDrivers = vehicle.allowedDrivers.toList();
    await showModalBottomSheet(
        context: context,
        builder: (builder) {
          return AllowDriversSheet(
              allowedDrivers: allowedDrivers,
              allDrivers: appData.drivers,
              vehicle: vehicle);
        });
  }
}
