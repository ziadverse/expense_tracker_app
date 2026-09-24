import 'package:expense_tracker_app/features/home/data/models/type_enum.dart';
import 'package:expense_tracker_app/features/home/data/models/income_categories_enum.dart';

import 'Transaction.dart';
import 'expense_categories_enum.dart';

class IncomeTransaction extends TransactionModel {
  IncomeCategories? category;

  IncomeTransaction({
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

  factory IncomeTransaction.fromJson(Map<String, dynamic> json) {
    return IncomeTransaction(
      id: json['id'],
      type: TransactionType.values.byName(json['type']),
      date: DateTime.parse(json['date']),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      category: IncomeCategories.values.byName(json['category']),
    );
  }
}
