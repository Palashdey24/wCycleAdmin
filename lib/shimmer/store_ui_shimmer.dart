import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wcycle_admin_panel/widgets/store_item.dart';

class StoreUiShimmer extends StatelessWidget {
  const StoreUiShimmer({super.key, this.isVertical});

  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (int a = 1; a <= 5; a++) const StoreItem(),
          ],
        ));
  }
}
