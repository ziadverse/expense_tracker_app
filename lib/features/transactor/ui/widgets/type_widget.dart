import 'package:flutter/material.dart';

class TypeWidget extends StatelessWidget {
  final bool isClicked;
  final String text;
  final Color color;

  const TypeWidget({
    required this.text,
    required this.isClicked,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(12),
      decoration: BoxDecoration(
        color: isClicked ? color : Colors.white,
        border: .all(color: isClicked ? color : color, width: 1.5),
        borderRadius: .circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: .bold,
          fontSize: 18,
          color: isClicked ? Colors.white : color,
        ),
      ),
    );
  }
}
