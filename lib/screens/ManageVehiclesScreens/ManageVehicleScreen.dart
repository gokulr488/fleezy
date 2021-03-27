import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/DataAccess/Roles.dart';
import 'package:fleezy/DataAccess/Vehicle.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/ManageVehicleCard.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/AllowDriversBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageVehicleScreen extends StatelessWidget {
  static const String id = 'manageVehicleScreen';
  @override
  Widget build(BuildContext context) {
    ManageVehicleCard vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
        headerText: 'Manage Vehicle',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              vehicle,
              ButtonCard(
                  buttonText: 'Tax Payment',
                  onTap: () => Navigator.pop(context)),
              ButtonCard(
                  buttonText: 'Insurance Payment',
                  onTap: () => Navigator.pop(context)),
              ButtonCard(
                  buttonText: 'Allowed Drivers',
                  onTap: () {
                    allowedDrivers(context, vehicle.vehicle);
                  }),
              ButtonCard(
                  buttonText: 'Delete Vehicle',
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
                                      String resp = await deleteVehicle(
                                          context, vehicle.vehicle);
                                      Navigator.of(context).pop();
                                      showSubmitResponse(context, resp);
                                    },
                                    child: Text('YES'))
                              ]);
                        });
                  }),
              SizedBox(height: 15)
            ]));
  }

  deleteVehicle(BuildContext context, ModelVehicle vehicle) async {
    showSendingDialogue(context);
    String resp = await Vehicle().deleteVehicle(vehicle);
    Provider.of<AppData>(context, listen: false).deleteVehicle(vehicle);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    return resp;
  }

  void allowedDrivers(BuildContext context, ModelVehicle vehicle) async {
    AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData.drivers == null) {
      List<ModelUser> drivers =
          await Roles().getAllUsersInCompany(appData.user.companyId);
      appData.setDrivers(drivers);
    }
    List<String> allowedDrivers = vehicle.allowedDrivers.toList();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return AllowDriversSheet(
              allowedDrivers: allowedDrivers,
              allDrivers: appData.drivers,
              vehicle: vehicle);
        });
  }
}
