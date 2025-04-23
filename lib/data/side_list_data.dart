import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_admin_panel/model/side_item_model.dart';

final List<SideItemModel> sideListData = [
  SideItemModel(
      faIcon: FontAwesomeIcons.gauge,
      ltTitle: "Dashboard",
      color: Colors.cyan,
      isActive: true,
      ltPositon: 0),
  SideItemModel(
      faIcon: FontAwesomeIcons.recycle,
      ltTitle: "Recycle Item",
      color: Colors.green,
      isActive: false,
      ltPositon: 1),
  SideItemModel(
      faIcon: FontAwesomeIcons.newspaper,
      ltTitle: "Littered Spot",
      color: Colors.lime,
      isActive: false,
      ltPositon: 2),
  SideItemModel(
      faIcon: FontAwesomeIcons.leaf,
      ltTitle: "Events",
      color: Colors.amberAccent,
      isActive: false,
      ltPositon: 3),
  SideItemModel(
      faIcon: FontAwesomeIcons.newspaper,
      ltTitle: "News",
      color: Colors.lime,
      isActive: false,
      ltPositon: 4),
  SideItemModel(
      faIcon: FontAwesomeIcons.store,
      ltTitle: "Store",
      color: Colors.lightGreen,
      isActive: false,
      ltPositon: 5),
];
