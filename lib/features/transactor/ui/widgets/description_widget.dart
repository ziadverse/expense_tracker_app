import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final TextEditingController controller;
  const DescriptionWidget({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Color(0xFF6B3FA0), fontSize: 18),
      decoration: InputDecoration(
          contentPadding: .symmetric(horizontal: 18, vertical: 20),
          filled: true,
          fillColor: Colors.white,
          labelText: "Description",
          labelStyle: TextStyle(color: Color(0xFF6B3FA0), fontSize: 18),
          border: OutlineInputBorder(borderRadius: .circular(16)),
          focusedBorder: OutlineInputBorder(borderRadius: .circular(16)),
          enabledBorder: OutlineInputBorder(borderRadius: .circular(16))
      ),
    );
  }
}
