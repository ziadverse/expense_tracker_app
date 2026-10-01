import 'package:expense_tracker_app/features/home/models/income_category.dart';
import 'package:expense_tracker_app/features/home/models/transaction_model.dart';
import 'package:expense_tracker_app/features/home/models/transaction_type.dart';
import 'expense_category.dart';

class ExpenseTransaction extends TransactionModel {
  ExpenseCategory? category;

  ExpenseTransaction({
    super.id,
    required super.amount,
    required super.description,
    required super.type,
    required super.date,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amount": amount,
      "description": description,
      "type": type!.name,
      "date": date!.toIso8601String(),
      "category": category!.name,
    };
  }

  factory ExpenseTransaction.fromJson(Map<String, dynamic> json){
    return ExpenseTransaction(id: json['id'], amount: json['amount'], description: json['description'], type: TransactionType.values.byName(json['type']), date: DateTime.parse(json['date']), category: ExpenseCategory.values.byName(json['category']));
  }
}
