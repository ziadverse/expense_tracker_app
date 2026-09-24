import 'package:expense_tracker_app/features/home/data/models/type_enum.dart';
import 'package:flutter/material.dart';

class TypeComboBoxWidget extends StatelessWidget {
  final TransactionType? type;
  final ValueChanged<TransactionType?> onChanged;

  const TypeComboBoxWidget({
    super.key,
    required this.type,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TransactionType>(
      decoration: const InputDecoration(labelText: 'Category'),
      value: type,
      items: TransactionType.values.map((category) {
        return DropdownMenuItem(value: category, child: Text(category.name));
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) return 'Please select a type';
        return null;
      },
    );
  }
}
