import 'package:expense_tracker_app/core/constants/cat_icon_map.dart';
import 'package:expense_tracker_app/features/home/data/models/expense_transaction.dart';
import 'package:flutter/material.dart';

class ExpenseListTileWidget extends StatefulWidget {
  final ExpenseTransaction? model;
  final void Function() onUpdate;
  final void Function() onDelete;

  const ExpenseListTileWidget({required this.model, required this.onUpdate, required this.onDelete, super.key});

  @override
  State<ExpenseListTileWidget> createState() => _IncomeListTileWidgetState();
}

class _IncomeListTileWidgetState extends State<ExpenseListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CatIconMap.getIcon(widget.model!.category.toString()),
      title: Row(
        children: [
          Text(widget.model!.category.toString()),
          Text("-${widget.model!.amount.toString()}")
        ],
      ),
      trailing: Row(
        children: [
          IconButton(onPressed: widget.onUpdate, icon: Icon(Icons.edit)),
          IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}