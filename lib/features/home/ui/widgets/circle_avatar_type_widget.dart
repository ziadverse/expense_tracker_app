import 'package:flutter/material.dart';

class CircleAvatarTypeWidget extends StatelessWidget {
  final IconData? icon;
  final Color? iconForegroundColor;
  final Color? iconBackgroundColor;
  const CircleAvatarTypeWidget({required this.icon, required this.iconForegroundColor, required this.iconBackgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: iconBackgroundColor,
      child: Icon(icon, color: iconForegroundColor, size: 18),
    );
  }
}
