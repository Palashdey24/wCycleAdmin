import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/model/store_model.dart';
import 'package:wcycle_admin_panel/widgets/store_profie/store_profile_feature_list_ui_box.dart';
import 'package:wcycle_admin_panel/widgets/store_profie/update_store_status.dart';

const List<String> featureList = ["Products", "Document", "Services"];

class StoreProfileFeatureListUi extends StatelessWidget {
  const StoreProfileFeatureListUi(
      {super.key,
      this.onPressedTittle,
      this.storeRecycleLength,
      required this.storeModel,
      this.stopWebview});

  final void Function(String tittle)? onPressedTittle;
  final void Function()? stopWebview;
  final int? storeRecycleLength;
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoreProfileFeatureListUiBox(featureList: [
          for (final featureTittle in featureList)
            TextButton(
              onPressed: () {
                if (onPressedTittle != null) {
                  onPressedTittle!(featureTittle);
                }
              },
              child: Text(
                featureTittle,
                style: AppFont.textMedium(context)
                    .copyWith(color: AppColor.kDarkColor),
              ),
            ),
        ]),
        StoreProfileFeatureListUiBox(featureList: [
          Flex(
            direction: Axis.horizontal,
            spacing: AppGap.kMediumGap,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 2; i++)
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      i == 0 ? storeRecycleLength.toString() : "\$ 10k",
                      style: AppFont.textMedium(context)
                          .copyWith(color: AppColor.kSixthColor),
                    ),
                    Text(
                      i == 0 ? "Total Product" : "Total Earning",
                      style: AppFont.textMedium(context)
                          .copyWith(color: AppColor.kDarkColor),
                    ),
                  ],
                ),
            ],
          )
        ]),
        StoreProfileFeatureListUiBox(featureList: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Status",
                style: AppFont.textMedium(context)
                    .copyWith(color: AppColor.kDarkColor),
              ),
              IconButton(
                  onPressed: () {
                    stopWebview!();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateStoreStatus(
                          storeStatus: storeModel.storeStatus ?? "N/A",
                          storeId: storeModel.id ?? "N/A",
                        );
                      },
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.solidPenToSquare,
                    color: AppColor.kLightColor,
                    size: 15,
                  ))
            ],
          ),
          Text(
            storeModel.storeStatus ?? "Under",
            style: AppFont.textMedium(context)
                .copyWith(color: AppColor.kLightColor),
          )
        ]),
      ],
    );
  }
}
