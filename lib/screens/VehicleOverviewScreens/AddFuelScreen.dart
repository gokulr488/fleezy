import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFuelScreen extends StatefulWidget {
  static const String id = 'addFuelScreen';
  @override
  _AddFuelScreenState createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  String payMode = 'CASH';
  String totalPrice = '';
  String pricePerLitre = '';
  String litres = '';
  String odometerReading = '';
  bool isFullTank = false;
  @override
  Widget build(BuildContext context) {
    String regNumber = ModalRoute.of(context).settings.arguments;
    AppData appdata = Provider.of<AppData>(context, listen: false);
    return BaseScreen(
        headerText: 'Add Fuel',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              VehicleCard(
                registrationNumber: regNumber,
                currentDriver:
                    appdata.user.fullName ?? appdata.user.phoneNumber,
              ),
              SizedBox(height: 15),
              Expanded(
                  child: ScrollableList(childrenHeight: 65, items: [
                DropDown(
                    defaultValue: payMode,
                    values: ['CASH', 'BPL Card', 'Debit Card'],
                    onChanged: (String value) {
                      payMode = value;
                    },
                    hintText: 'Payment Type'),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      totalPrice = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Total Price')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      pricePerLitre = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Price Per litre')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      litres = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Litres filled')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      odometerReading = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Odometer Reading')),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Full Tank',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: kHighlightColour)),
                      Checkbox(
                          activeColor: kHighlightColour,
                          value: isFullTank,
                          onChanged: (bool value) {
                            setState(() {
                              isFullTank = value;
                            });
                          })
                    ])
              ])),
              RoundedButton(
                  title: 'Add Fuel', onPressed: () => Navigator.pop(context))
            ]));
  }
}
//TODO complete the APIs and impl
