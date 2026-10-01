import 'package:expense_tracker_app/core/extensions/num_extensions.dart';
import 'package:expense_tracker_app/features/home/models/user_model.dart';
import 'package:expense_tracker_app/features/home/ui/widgets/circle_avatar_type_widget.dart';
import 'package:flutter/material.dart';

class TypeContainerWidget extends StatelessWidget {
  final String? type;
  final IconData? icon;
  final UserModel? user;
  final Color? iconForegroundColor;
  final Color? iconBackgroundColor;
  final int? moneyType;

  const TypeContainerWidget({required this.type, required this.icon, required this.user, required this.moneyType, required this.iconBackgroundColor, required this.iconForegroundColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: .circular(16),
      ),
      child: Row(
        children: [
          CircleAvatarTypeWidget(icon: icon, iconForegroundColor: iconForegroundColor, iconBackgroundColor: iconBackgroundColor),
          30.hGap,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type!,
                style: TextStyle(color: Color(0xFFD8DAE8), fontSize: 22),
              ),
              Row(
                children: [
                  22.hGap,
                  Text(
                    moneyType.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
