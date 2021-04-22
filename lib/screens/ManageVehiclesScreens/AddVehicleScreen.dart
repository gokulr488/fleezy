import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataAccess/DAOs/Vehicle.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DatePicker.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _kHeaderTextStyle = TextStyle(
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
        children: [
          // SizedBox(height: 20),
          Text('Vehicle Details', style: _kHeaderTextStyle),
          SizedBox(height: 30),
          Expanded(
            child: ScrollableList(childrenHeight: 80, items: [
              TextField(
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) {
                    vehicle.registrationNo = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Registration Number')),
              TextField(
                  onChanged: (value) {
                    vehicle.vehicleName = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Vehicle Name')),
              TextField(
                  onChanged: (value) {
                    vehicle.brand = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Brand')),
              TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    try {
                      vehicle.latestOdometerReading = int.parse(value);
                    } catch (e) {
                      print(e);
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

          ButtonCard(onTap: _addVehicleToDb, buttonText: 'Add Vehicle')
        ],
      ),
    );
  }

  void _addVehicleToDb() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (vehicle.registrationNo == null ||
        vehicle.vehicleName == null ||
        vehicle.latestOdometerReading == null) {
      message = 'Some fields are missing';
      print(message);
      return;
    }
    AppData appData = Provider.of<AppData>(context, listen: false);
    vehicle.companyId = appData.user.companyId;
    vehicle.isInTrip = false;
    vehicle.allowedDrivers = [appData.user.phoneNumber];
    Vehicle().addVehicle(vehicle);
    Provider.of<AppData>(context, listen: false).addNewVehicle(vehicle);
    print('Adding vehicle');
    Navigator.pop(context, vehicle);
  }

  String _getInsuranceExpiryDate() {
    String expiryDate = '';
    if (vehicle != null && vehicle.insuranceExpiryDate != null) {
      expiryDate = Utils.getFormattedTimeStamp(vehicle.insuranceExpiryDate);
    }
    return expiryDate;
  }

  String _getTaxExpiryDate() {
    String expiryDate = '';
    if (vehicle != null && vehicle.taxExpiryDate != null) {
      expiryDate = Utils.getFormattedTimeStamp(vehicle.taxExpiryDate);
    }
    return expiryDate;
  }
}
