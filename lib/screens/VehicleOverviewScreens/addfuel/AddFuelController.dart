import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:flutter/material.dart';

class AddFuelController {
  ModelExpense expenseDo;
  TextEditingController litresController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  void init() {
    expenseDo = ModelExpense();
    expenseDo.isFullTank = false;
  }

  onAddFuel(BuildContext context) {
    print('');
  }

  calcLitresFilled() {
    if (expenseDo?.fuelUnitPrice != null &&
        expenseDo?.amount != null &&
        expenseDo.fuelUnitPrice > 0 &&
        expenseDo.amount > 0) {
      expenseDo.fuelQty = expenseDo.amount / expenseDo.fuelUnitPrice;
      litresController.text = expenseDo.fuelQty.toStringAsFixed(3);
    }
  }

  calcTotalPrice() {
    if (expenseDo?.fuelUnitPrice != null &&
        expenseDo?.fuelQty != null &&
        expenseDo.fuelUnitPrice > 0 &&
        expenseDo.fuelQty > 0) {
      expenseDo.amount = (expenseDo.fuelQty * expenseDo.fuelUnitPrice);
      totalPriceController.text = expenseDo.amount.toStringAsFixed(3);
    }
  }

  void dispose() {
    litresController.dispose();
    totalPriceController.dispose();
  }
}
