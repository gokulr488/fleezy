import 'package:fleezy/Common/AppData.dart';
import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DropDown.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/VehicleCard.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addexpense/AddExpenseController.dart';
import 'package:fleezy/services/ImageViewerScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseScreen extends StatefulWidget {
  static const String id = 'addExpenseScreen';
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  AddExpenseController ctrl;
  final TextStyle _ts = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: kHighlightColour);

  @override
  void initState() {
    super.initState();
    ctrl = AddExpenseController();
  }

  @override
  Widget build(BuildContext context) {
    final String regNumber =
        ModalRoute.of(context).settings.arguments as String;
    final AppData appdata = Provider.of<AppData>(context, listen: false);
    return BaseScreen(
        headerText: 'Add Expense',
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
                  child: ScrollableList(childrenHeight: 90, items: [
                DropDown(
                    defaultValue: ctrl.expenseDo.expenseType,
                    values: Constants.EXPENSE_TYPES,
                    onChanged: (String value) {
                      ctrl.expenseDo.expenseType = value;
                    },
                    hintText: 'Expense Type'),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      ctrl.expenseDo.amount = double.parse(value);
                    },
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: 'Amount')),
                TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      ctrl.expenseDo.odometerReading = int.parse(value);
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Odometer Reading')),
                TextFormField(
                    minLines: 4,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      ctrl.expenseDo.expenseDetails = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Details of Expense'))
              ])),
              Row(
                children: [
                  _getPhotoWidget(),
                  IconButton(
                      onPressed: () async {
                        await ctrl.takePhoto();
                        setState(() {});
                      },
                      icon: const Icon(Icons.camera_alt_outlined),
                      iconSize: 50),
                ],
              ),
              RoundedButton(
                  title: 'Add Expense',
                  onPressed: () => ctrl.onAddExpense(context, regNumber))
            ]));
  }

  Widget _getPhotoWidget() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: ctrl.photo != null
          ? GestureDetector(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                child: Image.file(
                  ctrl.photo,
                  height: 100,
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<ImageViewerScreen>(
                      builder: (BuildContext context) =>
                          ImageViewerScreen(photo: ctrl.photo))),
            )
          : Center(child: Text('Add Expense Bill', style: _ts)),
    );
  }
}
