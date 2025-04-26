import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/model/littered_model.dart';
import 'package:wcycle_admin_panel/shimmer/lt_shimmer.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/littered_list_item.dart';
import 'package:wcycle_admin_panel/widgets/search_box/search_box_core.dart';

final apis = Apis();

List<String> rcTittle = [
  "ID",
  "Product Name",
  "Impact Level",
  "Price",
  "Online",
  "ShopName",
];

class LitteredSpotPage extends StatelessWidget {
  const LitteredSpotPage({super.key});

  static const pageConfig =
      PageConfig(pageName: "littered_page", child: LitteredSpotPage());

  @override
  Widget build(BuildContext context) {
    List<LitteredModel> litteredDataList = [];
    final deviceWidth = DeviceSize.getDeviceWidth(context);
    return Card(
      color: AppColor.kSixthColor.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(deviceWidth * 0.02)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          spacing: AppGap.kNormalGap,
          children: [
            const Gap(csGap),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Littered List",
                  style: AppFont.textMedium(context)
                      .copyWith(color: AppColor.kSecondColor),
                ),
                Flex(
                  direction: Axis.horizontal,
                  spacing: AppGap.kNormalGap,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: deviceWidth * 0.15,
                        height: 80,
                        child: const SearchBoxCore()),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.navigate_before_rounded,
                          color: AppColor.kLightColor,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.navigate_next_rounded,
                          color: AppColor.kLightColor,
                        )),
                  ],
                )
              ],
            ),
            const Gap(AppGap.kNormalGap),
            SizedBox(
              height: apis.deviceHeight(context) - bottomGap,
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("litteredSpot")
                      .get(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox(
                          height: 150,
                          child: LtShimmer(),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final litteredData = snapshot.data!.docs;
                        //Add data to model list one after one
                        litteredDataList = litteredData.map((e) {
                          return LitteredModel.fromJson(e.data());
                        }).toList();
                    }
                    return GridView.builder(
                      itemCount: litteredDataList.length,
                      itemBuilder: (context, index) {
                        return LitteredListItem(
                          ltListModel: litteredDataList[index],
                        );
                      },
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio:
                              DeviceSize.getDeviceHeight(context) > 1000
                                  ? 0.75
                                  : 1,
                          mainAxisSpacing: AppGap.kLargeGap,
                          crossAxisSpacing: AppGap.kMediumGap),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
