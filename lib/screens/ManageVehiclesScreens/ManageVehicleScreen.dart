import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/DataAccess/DAOs/Roles.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
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
    final ManageVehicleCard vehicle =
        ModalRoute.of(context).settings.arguments as ManageVehicleCard;
    return BaseScreen(
        headerText: 'Manage Vehicle',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IgnorePointer(child: vehicle),
              const SizedBox(height: 15),
              GridLayout(children: <Widget>[
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
                          builder: (BuildContext context) {
                            return Alerts(
                                title: 'Delete this vehicle ?',
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('NO')),
                                  TextButton(
                                      onPressed: () async {
                                        final String resp = await deleteVehicle(
                                            context, vehicle.vehicle);
                                        Navigator.of(context).pop();
                                        showSubmitResponse(context, resp);
                                      },
                                      child: const Text('YES'))
                                ]);
                          });
                    })
              ])
            ]));
  }

  Future<String> deleteVehicle(
      BuildContext context, ModelVehicle vehicle) async {
    showSendingDialogue(context);
    final String resp = await Vehicle().deleteVehicle(vehicle);
    Provider.of<AppData>(context, listen: false).deleteVehicle(vehicle);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    return resp;
  }

  Future<void> allowedDrivers(
      BuildContext context, ModelVehicle vehicle) async {
    final AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData.drivers == null) {
      final List<ModelUser> drivers = await Roles()
          .getAllUsersInCompany(appData.selectedCompany.companyEmail);
      appData.setDrivers(drivers);
    }
    final List<String> allowedDrivers = vehicle.allowedDrivers.toList();
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return AllowDriversSheet(
              allowedDrivers: allowedDrivers,
              allDrivers: appData.drivers,
              vehicle: vehicle);
        });
  }
}
