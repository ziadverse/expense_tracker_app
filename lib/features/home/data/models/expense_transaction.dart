import 'package:expense_tracker_app/features/home/data/models/type_enum.dart';

import 'Transaction.dart';
import 'expense_categories_enum.dart';

class ExpenseTransaction extends TransactionModel {
  ExpenseCategories? category;

  ExpenseTransaction({
    super.id,
    required super.type,
    required super.date,
    required super.amount,
    required super.description,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'date': date.toIso8601String(),
      'amount': amount.toInt(),
      'description': description,
      'category': category?.name
    };
  }

  factory ExpenseTransaction.fromJson(Map<String, dynamic> json) {
    return ExpenseTransaction(
      id: json['id'],
      type: TransactionType.values.byName(json['type']),
      date: DateTime.parse(json['date']),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      category: ExpenseCategories.values.byName(json['category']),
    );
  }
}
