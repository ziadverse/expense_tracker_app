import 'package:expense_tracker_app/features/home/models/transaction_type.dart';
import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TransactionType? type;
  const AmountWidget({required this.type, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: type == TransactionType.income? Color(0xFF4CD964): Color(0xFFFF6B6B), fontSize: 32),
      decoration: InputDecoration(
          contentPadding: .symmetric(horizontal: 18, vertical: 20),
          filled: true,
          fillColor: Color(0xFFFDF8FF),
          border: OutlineInputBorder(borderRadius: .circular(16)),
          focusedBorder: OutlineInputBorder(borderRadius: .circular(16)),
          enabledBorder: OutlineInputBorder(borderRadius: .circular(16))
      ),
    );
  }
}
