import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addfuel/AddFuelController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFuelScreen extends StatefulWidget {
  static const String id = 'addFuelScreen';
  @override
  _AddFuelScreenState createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  AddFuelController controller;
  @override
  void initState() {
    controller = AddFuelController();
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

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
                    defaultValue: controller.expenseDo.payMode,
                    values: ['CASH', 'BPL Card', 'Debit Card'],
                    onChanged: (String value) {
                      controller.expenseDo.payMode = value;
                    },
                    hintText: 'Payment Type'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    controller.expenseDo.amount = double.parse(value);
                    controller.calcLitresFilled();
                    setState(() {});
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Total Price'),
                  controller: controller.totalPriceController,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      controller.expenseDo.fuelUnitPrice = double.parse(value);
                      controller.calcLitresFilled();
                      setState(() {});
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Price Per litre')),
                TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      controller.expenseDo.fuelQty = double.parse(value);
                      controller.calcTotalPrice();
                      setState(() {});
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Litres filled'),
                    controller: controller.litresController),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      controller.expenseDo.odometerReading = int.parse(value);
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
                          value: controller.expenseDo.isFullTank,
                          onChanged: (bool value) {
                            setState(() {
                              controller.expenseDo.isFullTank = value;
                            });
                          })
                    ])
              ])),
              RoundedButton(
                  title: 'Add Fuel',
                  onPressed: () => controller.onAddFuel(context))
            ]));
  }
}
//TODO complete the APIs and impl
