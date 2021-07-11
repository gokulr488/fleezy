import 'package:fleezy/Common/Constants.dart';
import 'package:fleezy/Common/UiConstants.dart';
import 'package:fleezy/Common/Utils.dart';
import 'package:fleezy/components/BaseScreen.dart';
import 'package:fleezy/components/DatePicker.dart';
import 'package:fleezy/components/RoundedButton.dart';
import 'package:fleezy/components/ScrollableList.dart';
import 'package:fleezy/components/cards/ManageVehicleCard.dart';
import 'package:fleezy/screens/HomeScreen.dart';
import 'package:fleezy/screens/HomeScreenPages/ManageCompanyScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehicleScreen.dart';
import 'package:fleezy/screens/ManageVehiclesScreens/ManageVehiclesScreen.dart';
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
    var vehicle =
        ModalRoute.of(context).settings.arguments as ManageVehicleCard;
    ctrl.vehicleDo = vehicle.vehicle;
    return BaseScreen(
        headerText: 'Insurance Payment',
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IgnorePointer(child: vehicle),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ScrollableList(childrenHeight: 80, items: [
                  DatePicker(
                      text: 'Insurance Expiry Date:  ${_getInsExpiryDate()}',
                      onTap: () async {
                        ctrl.expenseDo.insuranceExpiryDate =
                            Utils.getTimeStamp(await Utils.pickDate(context));
                        vehicle.vehicle?.insuranceExpiryDate =
                            ctrl.expenseDo?.insuranceExpiryDate;
                        setState(() {});
                      }),
                  Center(
                    child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          ctrl.expenseDo.amount = double.parse(value);
                        },
                        decoration:
                            kTextFieldDecoration.copyWith(labelText: 'Amount')),
                  ),
                  Center(
                    child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          ctrl.expenseDo.policyNumber = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Insurance Policy Number')),
                  ),
                  TextFormField(
                      minLines: 4,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        ctrl.expenseDo.expenseDetails = value;
                      },
                      decoration:
                          kTextFieldDecoration.copyWith(labelText: 'Remarks'))
                ]),
              )),
              RoundedButton(
                  title: 'Save Insurance Payment',
                  onPressed: () async {
                    final isSuccess = await ctrl.onAddExpense(context, null);
                    if (isSuccess) {
                      Navigator.popUntil(
                          context, ModalRoute.withName(HomeScreen.id));
                    }
                  })
            ]));
  }

  String _getInsExpiryDate() {
    var expiryDate = '';
    if (ctrl.expenseDo?.insuranceExpiryDate != null) {
      expiryDate = Utils.getFormattedTimeStamp(
          ctrl.expenseDo.insuranceExpiryDate, kDateFormat);
    }
    return expiryDate;
  }
}
