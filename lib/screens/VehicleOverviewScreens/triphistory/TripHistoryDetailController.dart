import 'package:fleezy/DataAccess/ExpenseApis.dart';
import 'package:fleezy/DataModels/ModelExpense.dart';
import 'package:fleezy/DataModels/ModelTrip.dart';
import 'package:fleezy/components/cards/ExpenseCard.dart';
import 'package:flutter/material.dart';

Future<List<ModelExpense>> getExpenses(
    ModelTrip tripDo, BuildContext context) async {
  final callContext = await ExpenseApis().getExpensesInTrip(tripDo, context);
  final expenses = callContext.data as List<ModelExpense>;
  return expenses;
}

List<ExpenseCard> buildCards(List<ModelExpense> expenses) {
  List<ExpenseCard> expenseCards = [];
  for (final expense in expenses) {
    expenseCards.add(ExpenseCard(
      expense: expense,
    ));
  }
  return expenseCards;
}
