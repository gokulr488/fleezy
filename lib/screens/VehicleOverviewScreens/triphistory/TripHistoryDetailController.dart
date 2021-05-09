import 'package:fleezy/Common/CallContext.dart';
import 'package:fleezy/DataAccess/ExpenseApis.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:flutter/material.dart';

void getExpenses(ModelTrip tripDo, BuildContext context) async {
  CallContext callContext =
      await ExpenseApis().getExpensesInTrip(tripDo, context);
  List<ModelExpense> expenses = callContext.data as List<ModelExpense>;
}
