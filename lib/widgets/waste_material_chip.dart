import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/loading_widget.dart';

final api = Apis();
final fontHelper = FontHelper();

class WasteMaterialChip extends StatefulWidget {
  const WasteMaterialChip(
      {super.key,
      required this.wasteMatFn,
      required this.fsCollection,
      required this.fsField});
  final void Function(List<String> waste) wasteMatFn;
  final String fsCollection;
  final String fsField;

  @override
  State<WasteMaterialChip> createState() => _WasteMaterialChipState();
}

class _WasteMaterialChipState extends State<WasteMaterialChip> {
  List<String> selectWasteMaterial = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.fireStore.collection(widget.fsCollection).get(),
      builder: (context, snapshot) {
        List<String> wasteMaterials = [];
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: SizedBox(width: 30, height: 30, child: LoadingWidgets()),
            );

          case ConnectionState.active:
          case ConnectionState.done:
            if (!snapshot.hasData) {
              return Center(
                child: Text("Some error Occurred ${snapshot.hasError}"),
              );
            } else {
              final wasteMatSnapshot = snapshot.data?.docs.toList();

              for (var wasteMat in wasteMatSnapshot!) {
                wasteMaterials.add(wasteMat[widget.fsField]);
              }
            }

            return Wrap(
              runSpacing: normalGap,
              spacing: csGap,
              children: [
                for (var wasmat in wasteMaterials)
                  ChoiceChip(
                    backgroundColor: Colors.grey,
                    selectedColor: Colors.lime,
                    label: Text(
                      wasmat.toUpperCase(),
                      style: fontHelper
                          .bodyMedium(context)
                          .copyWith(color: Colors.white),
                    ),
                    onSelected: (value) {
                      setState(() {
                        if (selectWasteMaterial.contains(wasmat)) {
                          selectWasteMaterial.remove(wasmat);
                        } else {
                          selectWasteMaterial.add(wasmat);
                        }
                      });
                      widget.wasteMatFn(selectWasteMaterial);
                      return;
                    },
                    selected: selectWasteMaterial.contains(wasmat),
                  ),
              ],
            );
        }
      },
    );
  }
}
