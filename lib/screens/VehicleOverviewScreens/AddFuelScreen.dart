import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ButtonCard.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:flutter/material.dart';

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
    VehicleCard vehicle = ModalRoute.of(context).settings.arguments;
    return BaseScreen(
        headerText: 'Add Fuel',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              vehicle,
              SizedBox(height: 15),
              Expanded(
                  child: ScrollableList(childrenHeight: 65, items: [
                DropdownButtonFormField<String>(
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: kHighlightColour,
                  ),
                  iconSize: 25,
                  decoration: kTextFieldDecoration,
                  value: payMode,
                  onChanged: (String value) {
                    setState(() {
                      payMode = value;
                    });
                  },
                  items: <String>['CASH', 'BPL Card', 'Debit Card']
                      .map((value) =>
                          DropdownMenuItem(value: value, child: Text(value)))
                      .toList(),
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      totalPrice = value;
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(hintText: 'Total Price')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      pricePerLitre = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Price Per litre')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      litres = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Litres filled')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      odometerReading = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Odometer Reading')),
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
              ButtonCard(
                  buttonText: 'Add Fuel', onTap: () => Navigator.pop(context))
            ]));
  }
}
