import 'package:expense_tracker_app/features/home/data/models/Transaction.dart';
import 'package:expense_tracker_app/features/home/data/models/type_enum.dart';
import 'package:expense_tracker_app/features/home/income_categories_enum.dart';

class IncomeTransaction extends TransactionModel {
  IncomeCategories? category;

  IncomeTransaction({
    super.id,
    required super.date,
    required super.type,
    required super.amount,
    required super.description,
    required this.category,
  })

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'date': date.toIso8601String(),
      'amount': amount,
      'description': description,
      'category': category?.name,
    };
  }

  factory IncomeTransaction.fromJson(Map<String, dynamic> json) {
    return IncomeTransaction(
      id: json['id'],
      date: DateTime.parse(json['date']),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
      category: json['category'] != null
          ? IncomeCategories.values.byName(json['category'])
          : null,
    );
  }
}