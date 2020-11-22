import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/DataModels/ModelVehicle.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/cards/BaseCard.dart';
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
              text:
                  'Insurance Expiry Date: ${DateTime.fromMillisecondsSinceEpoch(vehicle.insuranceExpiryDate.millisecondsSinceEpoch) ?? ''}',
              onTap: () async {
                vehicle.insuranceExpiryDate = await _selectDate(context);
                setState(() {});
              }),
          DatePicker(
              text: 'Tax Expiry Date:  ${vehicle.taxExpiryDate ?? ''}',
              onTap: () async {
                vehicle.taxExpiryDate = await _selectDate(context);
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
          )
        ],
      ),
    );
  }

  Future<Timestamp> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      return Timestamp.fromDate(picked);
    }
    return Timestamp.fromDate(selectedDate);
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
