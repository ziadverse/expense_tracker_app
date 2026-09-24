import 'package:expense_tracker_app/core/constants/cat_icon.dart';
import 'package:expense_tracker_app/core/constants/constant_assets.dart';
import 'package:flutter/material.dart';

class CatIconMap {
  CatIconMap._();

  static Image getIcon(String icon){
    switch(icon){
      case CatIcon.bills:
        return Image.asset(CatIcon.bills);
      case CatIcon.coffee:
        return Image.asset(CatIcon.coffee);
      case CatIcon.education:
        return Image.asset(CatIcon.education);
      case CatIcon.entertainment:
        return Image.asset(CatIcon.entertainment);
      case CatIcon.food:
        return Image.asset(CatIcon.food);
      case CatIcon.freelance:
        return Image.asset(CatIcon.freelance);
      case CatIcon.gift:
        return Image.asset(CatIcon.gift);
      case CatIcon.health:
        return Image.asset(CatIcon.health);
      case CatIcon.house:
        return Image.asset(CatIcon.house);
      case CatIcon.investment:
        return Image.asset(CatIcon.investment);
      case CatIcon.other:
        return Image.asset(CatIcon.other);
      case CatIcon.salary:
        return Image.asset(CatIcon.salary);
      case CatIcon.shopping:
        return Image.asset(CatIcon.shopping);
      case CatIcon.subscription:
        return Image.asset(CatIcon.subscription);
      case CatIcon.transport:
        return Image.asset(CatIcon.transport);
      case CatIcon.travel:
        return Image.asset(CatIcon.travel);
      default:
        return Image.asset(ConstantAssets.icon);
    }
  }
}