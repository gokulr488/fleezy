import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/Roles.dart';
import 'package:fleezy/DataAccess/Vehicle.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/ManageVehicleCard.dart';
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
                    allowerDrivers(context, vehicle);
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
                                FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('NO')),
                                FlatButton(
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

  void allowerDrivers(BuildContext context, ManageVehicleCard vehicle) async {
    AppData appData = Provider.of<AppData>(context, listen: false);
    if (appData.drivers == null) {
      List<ModelUser> drivers =
          await Roles().getAllUsersInCompany(appData.user.companyId);
      appData.setDrivers(drivers);
    }
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
              child: Column(
            children: [
              Expanded(
                  child: ScrollableList(
                      childrenHeight: 50,
                      items: getDriverChoosers(appData.drivers, vehicle))),
              RoundedButton(
                  onPressed: saveAllowedDrivers,
                  title: 'Save',
                  colour: kHighlightColour,
                  width: 200)
            ],
          ));
        });
  }

  List<Widget> getDriverChoosers(
      List<ModelUser> drivers, ManageVehicleCard vehicle) {
    List<Widget> driverChoosers = [];
    for (ModelUser driver in drivers) {
      driverChoosers.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            driver.fullName,
            style: TextStyle(fontSize: 17),
          ),
          Checkbox(
              activeColor: kHighlightColour,
              value: true, // Need to find out if this driver has access already
              onChanged: (bool value) {
                vehicle.vehicle.allowedDrivers.add(driver.phoneNumber);
              })
        ]),
      ));
    }
    return driverChoosers;
  }

  saveAllowedDrivers() {}
}
