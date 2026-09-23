import 'package:flutter/material.dart';

extension NumExtensions on num{
  SizedBox get vGap => SizedBox(height: toDouble());
  SizedBox get hGap => SizedBox(width: toDouble());
  Duration get sec => Duration(seconds: toInt());
}