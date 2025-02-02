import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';

class RecycleShimmer extends StatelessWidget {
  const RecycleShimmer({super.key, this.isVertical});

  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColor.kSixthColor,
        highlightColor: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            for (int a = 1; a <= 5; a++)
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int b = 0; b <= 4; b++)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppGap.kLargeGap,
                          horizontal: AppGap.kMediumGap),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppGap.kLargeGap)),
                      child: Text(
                        "Loading",
                        style: AppFont.textSmall(context),
                      ),
                    ),
                ],
              ),
          ],
        ));
  }
}
