import 'package:wcycle_admin_panel/model/recyclable_list_model.dart';

enum ImapctLevel { High, MediumHigh, LowHigh, Medium, Low, Normal }

final recyclable = [
  const RecyclableListModel(
      rcName: "iron",
      rcImpact: ImapctLevel.Low,
      rcPrice: 35.00,
      imgRsc: "assets/metal-iron.jpg"),
  const RecyclableListModel(
      rcName: "Plastic",
      rcImpact: ImapctLevel.High,
      rcPrice: 10.00,
      imgRsc: "assets/plastic_bottle.png"),
  const RecyclableListModel(
      rcName: "iron",
      rcImpact: ImapctLevel.Low,
      rcPrice: 35.00,
      imgRsc: "assets/metal-iron.jpg"),
  const RecyclableListModel(
      rcName: "Plastic",
      rcImpact: ImapctLevel.High,
      rcPrice: 10.00,
      imgRsc: "assets/plastic-bottles.jpg"),
];
