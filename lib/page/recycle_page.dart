import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';
import 'package:wcycle_admin_panel/model/store_model.dart';
import 'package:wcycle_admin_panel/shimmer/recycle_shimmer.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/recyclable_list_item_info.dart';
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

class RecyclePage extends StatelessWidget {
  const RecyclePage({super.key});

  static const pageConfig =
      PageConfig(pageName: "recycle_page", child: RecyclePage());

  @override
  Widget build(BuildContext context) {
    List<RecycleProductModel> recycleDataList = [];
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
                  "Product List",
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
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (final rcTitle in rcTittle)
                  Text(
                    rcTitle,
                    style: AppFont.textMedium(context),
                  ),
              ],
            ),
            SizedBox(
              height: apis.deviceHeight(context) - 400,
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("recycleProduct")
                      .get(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox(
                          height: 150,
                          child: RecycleShimmer(),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final recycleData = snapshot.data!.docs;
                        //Add data to model list one after one
                        recycleDataList = recycleData.map((e) {
                          return RecycleProductModel.fromJson(e.data());
                        }).toList();

                        for (var e in recycleDataList) {
                          FirebaseFirestore.instance
                              .collection("store")
                              .doc(e.shopID)
                              .get()
                              .then(
                            (value) {
                              recycleDataList[recycleDataList.indexOf(e)]
                                      .storeData =
                                  StoreModel.fromJson(value.data());
                              return;
                            },
                          );
                        }
                    }
                    return ListView.builder(
                      itemCount: recycleDataList.length,
                      itemBuilder: (context, index) {
                        return RecyclableListItemInfo(
                            rcListModel: recycleDataList[index]);
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
