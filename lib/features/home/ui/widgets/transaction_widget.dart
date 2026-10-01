import 'package:expense_tracker_app/core/constants/assets_map.dart';
import 'package:expense_tracker_app/core/extensions/num_extensions.dart';
import 'package:expense_tracker_app/features/home/models/expense_transaction.dart';
import 'package:expense_tracker_app/features/home/models/income_transaction.dart';
import 'package:expense_tracker_app/features/home/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel? transaction;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionWidget({
    required this.transaction,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat('d MMM yyyy').format(transaction!.date!);
    final bool isIncome = transaction is IncomeTransaction;
    final String category = isIncome
        ? (transaction! as IncomeTransaction).category!.name
        : (transaction! as ExpenseTransaction).category!.name;
    final Color color = isIncome
        ? const Color(0xFF4CD964)
        : const Color(0xFFFF6B6B);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A6B3FA0),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: Image.asset(
              isIncome
                  ? AssetsMap.getIncomeImage(
                (transaction! as IncomeTransaction).category!,
              )
                  : AssetsMap.getExpenseImage(
                (transaction! as ExpenseTransaction).category!,
              ),
            ),
          ),
          16.hGap,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction!.description!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.vGap,
                Text(
                  "$category · $date",
                  style: const TextStyle(
                    color: Color(0xFF747A9C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isIncome ? '+' : '-'}${transaction!.amount}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: color,
                ),
              ),
              8.vGap,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: onEdit,
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.edit,
                        size: 26,
                        color: Color(0xFF6B3FA0),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onDelete,
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.delete,
                        size: 26,
                        color: Color(0xFFFF6B6B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
