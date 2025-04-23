import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';

final fontHelpers = FontHelper();

class RecyclableListItemInfo extends StatelessWidget {
  const RecyclableListItemInfo({super.key, required this.rcListModel});

  final RecycleProductModel rcListModel;

  @override
  Widget build(BuildContext context) {
    final RecycleProductModel(
      :productName,
      :impactLevel,
      :productPrice,
      :productOnline
    ) = rcListModel;

    List<String> rcListItem = [
      productName,
      impactLevel,
      "$productPrice",
      "$productOnline"
    ];
    return InkWell(
      hoverColor: AppColor.kSixthColor,
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(productName)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppGap.kLargeGap, horizontal: AppGap.kMediumGap),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppGap.kLargeGap)),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "1",
              textAlign: TextAlign.center,
              style: AppFont.textSmall(context),
            ),
            for (final rcItem in rcListItem)
              Text(
                rcItem,
                textAlign: TextAlign.center,
                style: AppFont.textSmall(context),
              ),
            Text(
              rcListModel.storeData?.storeName ?? "DemoShop",
              textAlign: TextAlign.center,
              style: AppFont.textSmall(context),
            ),
          ],
        ),
      ),
    );
  }
}
