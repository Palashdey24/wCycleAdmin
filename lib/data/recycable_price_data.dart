import 'package:wcycle_admin_panel/model/recyclable_list_model.dart';

enum ImapctLevel { high, mediumHigh, lowHigh, medium, low, normal }

final recyclable = [
  const RecyclableListModel(
      rcName: "iron",
      rcImpact: ImapctLevel.low,
      rcPrice: 35.00,
      imgRsc: "assets/metal-iron.jpg"),
  const RecyclableListModel(
      rcName: "Plastic",
      rcImpact: ImapctLevel.high,
      rcPrice: 10.00,
      imgRsc: "assets/plastic_bottle.png"),
  const RecyclableListModel(
      rcName: "iron",
      rcImpact: ImapctLevel.low,
      rcPrice: 35.00,
      imgRsc: "assets/metal-iron.jpg"),
  const RecyclableListModel(
      rcName: "Plastic",
      rcImpact: ImapctLevel.high,
      rcPrice: 10.00,
      imgRsc: "assets/plastic-bottles.jpg"),
];
