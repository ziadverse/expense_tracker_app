import 'package:expense_tracker_app/core/constants/cat_icon_map.dart';
import 'package:expense_tracker_app/features/home/data/models/income_transaction.dart';
import 'package:flutter/material.dart';

class IncomeListTileWidget extends StatefulWidget {
  final IncomeTransaction? model;
  final void Function() onUpdate;
  final void Function() onDelete;

  const IncomeListTileWidget({required this.model, required this.onUpdate, required this.onDelete, super.key});

  @override
  State<IncomeListTileWidget> createState() => _IncomeListTileWidgetState();
}

class _IncomeListTileWidgetState extends State<IncomeListTileWidget> {
  @override
  Widget build(BuildContext context) {
          return ListTile(
            leading: CatIconMap.getIcon(widget.model!.category.toString()),
            title: Row(
              children: [
                Text(widget.model!.category.toString()),
                Text("+${widget.model!.amount.toString()}")
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

