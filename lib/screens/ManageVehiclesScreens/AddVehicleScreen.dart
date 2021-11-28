import 'package:fleezy/Common/Alerts.dart';
import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DatePicker.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const TextStyle _kHeaderTextStyle = TextStyle(
    fontSize: 30, fontWeight: FontWeight.bold, color: kHighlightColour);

class AddVehicleScreen extends StatefulWidget {
  static const String id = 'AddVehicleScreen';
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  ModelVehicle vehicle = ModelVehicle();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      headerText: 'Add New Vehicle',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // SizedBox(height: 20),
          const Text('Vehicle Details', style: _kHeaderTextStyle),
          const SizedBox(height: 30),
          Expanded(
            child: ScrollableList(childrenHeight: 80, items: <Widget>[
              TextField(
                  textCapitalization: TextCapitalization.words,
                  onChanged: (String value) {
                    vehicle.registrationNo = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Registration Number')),
              TextField(
                  onChanged: (String value) {
                    vehicle.vehicleName = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Vehicle Name')),
              TextField(
                  onChanged: (String value) {
                    vehicle.brand = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Brand')),
              TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    try {
                      vehicle.latestOdometerReading = int.parse(value);
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Current Odometer Reading in Kms')),
              DatePicker(
                  text: 'Insurance Expiry Date: ${_getInsuranceExpiryDate()}',
                  onTap: () async {
                    vehicle.insuranceExpiryDate =
                        Utils.getTimeStamp(await Utils.pickDate(context));
                    setState(() {});
                  }),
              DatePicker(
                  text: 'Tax Expiry Date:  ${_getTaxExpiryDate()}',
                  onTap: () async {
                    vehicle.taxExpiryDate =
                        Utils.getTimeStamp(await Utils.pickDate(context));
                    setState(() {});
                  })
            ]),
          ),

          RoundedButton(onPressed: _addVehicleToDb, title: 'Add Vehicle')
        ],
      ),
    );
  }

  Future<void> _addVehicleToDb() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (vehicle.registrationNo == null ||
        vehicle.vehicleName == null ||
        vehicle.latestOdometerReading == null) {
      message = 'Some fields are missing';
      debugPrint(message);
      return;
    }
    final AppData appData = Provider.of<AppData>(context, listen: false);
    vehicle.companyId = appData.selectedCompany.companyEmail;
    vehicle.isInTrip = false;
    vehicle.allowedDrivers = <String>[appData.user.phoneNumber];
    final CallContext callContext = await Vehicle().addVehicle(vehicle);
    if (callContext.isError) {
      showErrorAlert(context, callContext.errorMessage);
    } else {
      Provider.of<AppData>(context, listen: false).addNewVehicle(vehicle);
      debugPrint('Adding vehicle');
      Navigator.pop(context, vehicle);
    }
  }

  String _getInsuranceExpiryDate() {
    String expiryDate = '';
    if (vehicle?.insuranceExpiryDate != null) {
      expiryDate =
          Utils.getFormattedTimeStamp(vehicle.insuranceExpiryDate, kDateFormat);
    }
    return expiryDate;
  }

  String _getTaxExpiryDate() {
    String expiryDate = '';
    if (vehicle?.taxExpiryDate != null) {
      expiryDate =
          Utils.getFormattedTimeStamp(vehicle.taxExpiryDate, kDateFormat);
    }
    return expiryDate;
  }
}
