import 'package:expense_tracker_app/features/home/data/models/type_enum.dart';

class TransactionModel {
  int? id;
  TransactionType type;
  DateTime date;
  double amount;
  String description;

  TransactionModel({
    this.id,
    required this.type,
    required this.date,
    required this.amount,
    required this.description,
  });

}