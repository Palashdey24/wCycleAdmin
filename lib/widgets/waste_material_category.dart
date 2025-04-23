import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';
import 'package:wcycle_admin_panel/widgets/firebase_dropdown_helper.dart';

final dialoghelper = DialogsHelper();

class WasteMaterialCategory extends StatefulWidget {
  const WasteMaterialCategory({super.key, required this.wasteMatUpFn});

  final void Function(List<String> wasteMat) wasteMatUpFn;

  @override
  State<WasteMaterialCategory> createState() => _WasteMaterialCategoryState();
}

class _WasteMaterialCategoryState extends State<WasteMaterialCategory> {
  List<String> wasteMaterial = [];
  @override
  Widget build(BuildContext context) {
    return FirebaseDropdownHelper(
      onDropdownFn: (value) {
        if (wasteMaterial.contains(value)) {
          DialogsHelper.showMessage(context,
              "The material already Selected. Please choose different one");
          return;
        }

        setState(() {
          wasteMaterial.add(value);
        });
        widget.wasteMatUpFn(wasteMaterial);
      },
      dropHint: "Please select Material on Spot",
      dropLevel: "Waste Category",
      fsCollection: "wasteMaterial",
      fsField: "category",
    );
  }
}
