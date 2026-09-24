import 'package:expense_tracker_app/features/home/data/models/expense_categories_enum.dart';
import 'package:expense_tracker_app/features/home/data/models/income_categories_enum.dart';
import 'package:flutter/material.dart';

class IncomeCategoriesComboBoxWidget extends StatelessWidget {
  final IncomeCategories? selectedCategory;
  final ValueChanged<IncomeCategories?> onChanged;

  const IncomeCategoriesComboBoxWidget({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<IncomeCategories>(
      decoration: const InputDecoration(labelText: 'Category'),
      value: selectedCategory,
      items: IncomeCategories.values.map((category) {
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

