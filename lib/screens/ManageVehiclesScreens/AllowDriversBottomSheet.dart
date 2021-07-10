import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataModels/ModelUser.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:flutter/material.dart';

class AllowDriversSheet extends StatefulWidget {
  final List<ModelUser> allDrivers;
  final List<String> allowedDrivers;
  final ModelVehicle vehicle;
  AllowDriversSheet(
      {@required this.allowedDrivers, this.allDrivers, this.vehicle});
  @override
  _AllowDriversSheetState createState() => _AllowDriversSheetState();
}

class _AllowDriversSheetState extends State<AllowDriversSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Expanded(
            child: ScrollableList(
                childrenHeight: 50,
                items: getDriverChoosers(
                    widget.allDrivers, widget.allowedDrivers))),
        RoundedButton(
          onPressed: () async {
            await saveAllowedDrivers(
                widget.vehicle, widget.allowedDrivers, context);
          },
          title: 'Save',
        )
      ],
    ));
  }

  List<Widget> getDriverChoosers(
      List<ModelUser> allDrivers, List<String> allowedDrivers) {
    List<Widget> driverChoosers = [];
    for (final driver in allDrivers) {
      var allowed = allowedDrivers.contains(driver.phoneNumber);
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
              value: allowed,
              onChanged: (bool value) {
                allowed = !allowed;
                if (allowed) {
                  allowedDrivers.add(driver.phoneNumber);
                } else {
                  allowedDrivers.remove(driver.phoneNumber);
                }
                setState(() {});
              })
        ]),
      ));
    }
    return driverChoosers;
  }

  Future<void> saveAllowedDrivers(ModelVehicle vehicle,
      List<String> allowedDrivers, BuildContext context) async {
    final currentList = vehicle.allowedDrivers.toList();
    vehicle.allowedDrivers = allowedDrivers;
    final callContext = await Vehicle().updateVehicle(vehicle);
    if (callContext.isError) {
      showSubmitResponse(context, callContext.message);
      vehicle.allowedDrivers = currentList;
    } else {
      Navigator.pop(context);
      showSubmitResponse(context, callContext.message);
    }
  }
}
