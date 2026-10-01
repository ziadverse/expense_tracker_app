import 'package:flutter/material.dart';

class SaveButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;

  const SaveButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading? Color(0xFFE6DAF3) : Color(0xFF6B3FA0),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}