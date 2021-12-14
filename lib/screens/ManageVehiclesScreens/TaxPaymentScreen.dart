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

class TaxPaymentScreen extends StatefulWidget {
  static const String id = 'TaxPaymentScreen';
  @override
  _TaxPaymentScreenState createState() => _TaxPaymentScreenState();
}

class _TaxPaymentScreenState extends State<TaxPaymentScreen> {
  AddExpenseController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = AddExpenseController();
    ctrl.expenseDo.expenseType = Constants.TAX_EXP;
    ctrl.validateOdoMeter = false;
  }

  @override
  Widget build(BuildContext context) {
    final ManageVehicleCard vehicle =
        ModalRoute.of(context).settings.arguments as ManageVehicleCard;
    ctrl.vehicleDo ??= vehicle.vehicle;
    return BaseScreen(
        headerText: 'Tax Payment',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IgnorePointer(child: vehicle),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ScrollableList(childrenHeight: 80, items: [
                  DatePicker(
                      text: 'Tax Expiry Date:  ${_getTaxExpiryDate()}',
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
                  title: 'Save Tax Payment',
                  onPressed: () async {
                    final bool isSuccess =
                        await ctrl.onAddExpense(context, null);
                    if (isSuccess) {
                      vehicle.vehicle.taxExpiryDate =
                          ctrl.vehicleDo.taxExpiryDate;
                      Navigator.popUntil(
                          context, ModalRoute.withName(HomeScreen.id));
                    }
                  })
            ]));
  }

  Future<void> onDatePickerTap() async {
    final DateTime currentDate =
        Utils.getDateTime(ctrl.vehicleDo?.taxExpiryDate);
    final DateTime selectedDate =
        await Utils.pickDate(context, selectedDate: currentDate);
    ctrl.expenseDo.taxExpiryDate = Utils.getTimeStamp(selectedDate);
    ctrl.vehicleDo.taxExpiryDate = ctrl.expenseDo?.taxExpiryDate;
    setState(() {});
  }

  String _getTaxExpiryDate() {
    String expiryDate = '';
    if (ctrl.vehicleDo?.taxExpiryDate != null) {
      expiryDate = Utils.getFormattedTimeStamp(
          ctrl.vehicleDo.taxExpiryDate, kDateFormat);
    }
    return expiryDate;
  }
}
