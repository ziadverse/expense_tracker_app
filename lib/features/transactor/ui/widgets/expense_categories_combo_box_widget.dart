import 'package:expense_tracker_app/features/home/data/models/expense_categories_enum.dart';
import 'package:flutter/material.dart';

class ExpenseCategoriesComboBoxWidget extends StatelessWidget {
  final ExpenseCategories? selectedCategory;
  final ValueChanged<ExpenseCategories?> onChanged;

    const ExpenseCategoriesComboBoxWidget({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ExpenseCategories>(
      decoration: const InputDecoration(labelText: 'Category'),
      value: selectedCategory,
      items: ExpenseCategories.values.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.name),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) return 'Please select a category';
        return null;
      },
    );
  }
}
