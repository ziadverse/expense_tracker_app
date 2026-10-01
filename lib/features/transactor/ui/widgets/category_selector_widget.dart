import 'package:flutter/material.dart';

class CategorySelectorWidget extends StatelessWidget {
  final List<String> names;
  final int selectedIndex;
  final Color color;
  final ValueChanged<int> onSelected;

  const CategorySelectorWidget({
    super.key,
    required this.names,
    required this.selectedIndex,
    required this.color,
    required this.onSelected,
  });
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(names.length, (i) {
        final selected = selectedIndex == i;
        return ChoiceChip(
          label: Text(names[i]),
          selected: selected,
          selectedColor: color.withValues(alpha: 0.25),
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFD8DAE8)),
          labelStyle: TextStyle(
            color: selected ? color : const Color(0xFF747A9C),
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (_) => onSelected(i),
        );
      }),
    );
  }
}
