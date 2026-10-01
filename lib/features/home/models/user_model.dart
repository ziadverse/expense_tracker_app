import 'dart:math';

import 'package:expense_tracker_app/features/home/models/transaction_type.dart';

class UserModel {
  int? income;
  int? expense;
  int? balance;
  String? name;

  UserModel({this.balance, this.income, this.expense, this.name});

  void deposit(int amount){
    balance = balance! + amount;
    income = income! + amount;
  }

  void withdraw(int amount){
    if (amount <= balance!){
      balance = balance! - amount;
      expense = expense! + amount;
    }
  }

  void editTransaction(int oldAmount, int newAmount, TransactionType type){
    int diff;
    if (type == TransactionType.income){
      if (oldAmount > newAmount){
        diff = oldAmount - newAmount;
        balance = balance! - diff;
        income = income! - diff;
      }else{
        diff = newAmount - oldAmount;
        balance = balance! + diff;
        income = income! + diff;
      }
    }else {
      if (oldAmount > newAmount) {
        diff = oldAmount - newAmount;
        balance = balance! + diff;
        expense = expense! - diff;
      } else {
        diff = newAmount - oldAmount;
        balance = balance! - diff;
        expense = expense! + diff;
      }
    }
  }

}