import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DatePicker.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ManageVehicleCard.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/VehicleOverviewScreens/addexpense/AddExpenseController.dart';
import 'package:flutter/material.dart';

class InsurancePaymentScreen extends StatefulWidget {
  static const String id = 'InsurancePaymentScreen';
  @override
  _InsurancePaymentScreenState createState() => _InsurancePaymentScreenState();
}

class _InsurancePaymentScreenState extends State<InsurancePaymentScreen> {
  AddExpenseController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = AddExpenseController();
    ctrl.expenseDo.expenseType = Constants.INSURANCE_EXP;
    ctrl.validateOdoMeter = false;
  }

  @override
  Widget build(BuildContext context) {
    final ManageVehicleCard vehicle =
        ModalRoute.of(context).settings.arguments as ManageVehicleCard;
    ctrl.vehicleDo ??= vehicle.vehicle;
    return BaseScreen(
        headerText: 'Insurance Payment',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IgnorePointer(child: vehicle),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ScrollableList(childrenHeight: 80, items: <Widget>[
                  DatePicker(
                      text: 'Insurance Expiry Date:  ${_getInsExpiryDate()}',
                      onTap: onDatePickerTap),
                  Center(
                    child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (String value) {
                          ctrl.expenseDo.amount = double.parse(value);
                        },
                        decoration:
                            kTextFieldDecoration.copyWith(labelText: 'Amount')),
                  ),
                  Center(
                    child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (String value) {
                          ctrl.expenseDo.policyNumber = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Insurance Policy Number')),
                  ),
                  TextFormField(
                      minLines: 4,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      onChanged: (String value) {
                        ctrl.expenseDo.expenseDetails = value;
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: 'Remarks'))
                ]),
              )),
              RoundedButton(
                  title: 'Save Insurance Payment',
                  onPressed: () async {
                    final bool isSuccess =
                        await ctrl.onAddExpense(context, null);
                    if (isSuccess) {
                      Navigator.popUntil(
                          context, ModalRoute.withName(HomeScreen.id));
                    }
                  })
            ]));
  }

  Future<void> onDatePickerTap() async {
    final DateTime currentDate =
        Utils.getDateTime(ctrl.vehicleDo?.insuranceExpiryDate);
    final DateTime selectedDate =
        await Utils.pickDate(context, selectedDate: currentDate);
    ctrl.expenseDo.insuranceExpiryDate = Utils.getTimeStamp(selectedDate);
    ctrl.vehicleDo.insuranceExpiryDate = ctrl.expenseDo?.insuranceExpiryDate;
    setState(() {});
  }

  String _getInsExpiryDate() {
    String expiryDate = '';
    if (ctrl.vehicleDo?.insuranceExpiryDate != null) {
      expiryDate = Utils.getFormattedTimeStamp(
          ctrl.vehicleDo.insuranceExpiryDate, kDateFormat);
    }
    return expiryDate;
  }
}
