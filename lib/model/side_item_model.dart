import 'package:flutter/cupertino.dart';

class SideItemModel {
  SideItemModel({
    required this.ltPositon,
    required this.faIcon,
    required this.ltTitle,
    required this.color,
    required this.isActive,
  });

  final IconData faIcon;
  final String ltTitle;
  final Color color;
  final bool isActive;
  final int ltPositon;
}
