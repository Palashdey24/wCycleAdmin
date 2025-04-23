import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';

class StoreProfileFeatureListUiBox extends StatelessWidget {
  const StoreProfileFeatureListUiBox({super.key, required this.featureList});
  final List<Widget> featureList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppGap.kNormalGap),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Flex(
        spacing: AppGap.kNormalGap,
        direction: Axis.vertical,
        children: featureList,
      ),
    );
  }
}
