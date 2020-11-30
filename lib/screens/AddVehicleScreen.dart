import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/DataAccess/Vehicle.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

const _kHeaderTextStyle = TextStyle(
    fontSize: 30, fontWeight: FontWeight.bold, color: kHighlightColour);

const _kButtonTextTextStyle =
    TextStyle(fontSize: 30, fontFamily: 'FundamentoRegular');

class AddVehicleScreen extends StatefulWidget {
  static const String id = 'addVehicleScreen';
  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  ModelVehicle vehicle = ModelVehicle();
  String message = '';

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // SizedBox(height: 20),
          Text('Vehicle Details', style: _kHeaderTextStyle),
          // SizedBox(height: 30),

          TextField(
              textCapitalization: TextCapitalization.words,
              onChanged: (value) {
                vehicle.registrationNo = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Registration Number')),
          TextField(
              onChanged: (value) {
                vehicle.vehicleName = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Vehicle Name')),
          TextField(
              onChanged: (value) {
                vehicle.brand = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Brand')),
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
                  hintText: 'Current Odometer Reading in Kms')),
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
              }),
          BaseCard(
            elevation: 3,
            color: kHighlightColour,
            cardChild: Center(
              child: Text(
                'Add Vehicle',
                style: _kButtonTextTextStyle,
              ),
            ),
            onTap: _addVehicleToDb,
          )
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
    vehicle.companyId = HomeScreen.user.companyId;
    vehicle.isInTrip = false;
    vehicle.allowedDrivers = [HomeScreen.user.phoneNumber];
    Vehicle().addVehicle(vehicle);
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

class DatePicker extends StatelessWidget {
  final Function onTap;
  final String text;

  const DatePicker({this.onTap, this.text});
  @override
  Widget build(BuildContext context) {
    return BaseCard(
      elevation: 3,
      cardChild: SizedBox(
          height: 45,
          child: Center(child: Text(text, style: TextStyle(fontSize: 15)))),
      onTap: onTap,
    );
  }
}
