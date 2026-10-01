import 'package:expense_tracker_app/features/home/models/transaction_type.dart';

class TransactionModel {
  DateTime? date;
  int? id, amount;
  String? description;
  TransactionType? type;

  TransactionModel({this.id, required this.amount, required this.description, required this.type, required this.date});
}