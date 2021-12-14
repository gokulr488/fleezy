import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addfuel/AddFuelController.dart';
import 'package:fleezy/services/ImageViewerScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFuelScreen extends StatefulWidget {
  static const String id = 'addFuelScreen';
  @override
  _AddFuelScreenState createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  AddFuelController controller;
  final TextStyle _ts = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: kHighlightColour);
  @override
  void initState() {
    super.initState();
    controller = AddFuelController();
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String regNumber =
        ModalRoute.of(context).settings.arguments as String;
    final AppData appdata = Provider.of<AppData>(context, listen: false);
    return BaseScreen(
        headerText: 'Add Fuel',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IgnorePointer(
                child: VehicleCard(
                  registrationNumber: regNumber,
                  currentDriver:
                      appdata.user.fullName ?? appdata.user.phoneNumber,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                  child: ScrollableList(childrenHeight: 65, items: [
                DropDown(
                    defaultValue: controller.expenseDo.payMode,
                    values: const <String>['CASH', 'BPL Card', 'Debit Card'],
                    onChanged: (String value) {
                      controller.expenseDo.payMode = value;
                    },
                    hintText: 'Payment Type'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (String value) {
                    controller.expenseDo.amount = double.parse(value);
                    controller.calcLitresFilled();
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Total Price'),
                  controller: controller.totalPriceController,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      controller.expenseDo.fuelUnitPrice = double.parse(value);
                      controller.calcLitresFilled();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Price Per litre')),
                TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      controller.expenseDo.fuelQty = double.parse(value);
                      controller.calcTotalPrice();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Litres filled'),
                    controller: controller.litresController),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      controller.expenseDo.odometerReading = int.parse(value);
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Odometer Reading')),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Full Tank', style: _ts),
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
              Row(
                children: [
                  _getPhotoWidget(),
                  IconButton(
                      onPressed: () async {
                        await controller.takePhoto();
                        setState(() {});
                      },
                      icon: const Icon(Icons.camera_alt_outlined),
                      iconSize: 50),
                ],
              ),
              RoundedButton(
                  title: 'Add Fuel',
                  onPressed: () => controller.onAddFuel(context, regNumber))
            ]));
  }

  Widget _getPhotoWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: controller.photo != null
          ? GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Image.file(
                  controller.photo,
                  height: 100,
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<ImageViewerScreen>(
                      builder: (BuildContext context) =>
                          ImageViewerScreen(photo: controller.photo))),
            )
          : Center(child: Text('Add Fuel Bill', style: _ts)),
    );
  }
}
