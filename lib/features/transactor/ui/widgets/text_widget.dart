import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextEditingController controller;
  const TextWidget({required this.text, required this.icon, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Color(0xFFF5F0FA), fontSize: 18),
      decoration: InputDecoration(
          contentPadding: .symmetric(horizontal: 18, vertical: 20),
          filled: true,
          fillColor: Color(0xFF1A1A2E),
          labelText: text,
          labelStyle: TextStyle(color: Color(0xFFF5F0FA), fontSize: 16),
          prefixIcon: Icon(icon, color: Color(0xFFF5F0FA), size: 26),
          border: OutlineInputBorder(borderRadius: .circular(16)),
          focusedBorder: OutlineInputBorder(borderRadius: .circular(16)),
          enabledBorder: OutlineInputBorder(borderRadius: .circular(16))
      ),
    );
  }
}