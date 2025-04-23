import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/model/store_model.dart';

class StoreProfileIntro extends StatelessWidget {
  const StoreProfileIntro({super.key, required this.storeModel});
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    final StoreModel(
      :storeName,
      :storeAddress,
      :logoUri,
    ) = storeModel;
    return Container(
      padding: const EdgeInsets.all(AppGap.kLargeGap),
      height: 200,
      decoration:
          BoxDecoration(border: Border.all(color: AppColor.kSecondColor)),
      child: Flex(
        direction: Axis.horizontal,
        spacing: AppGap.kLargeGap,
        children: [
          Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.kSecondColor),
            child: CachedNetworkImage(
              imageUrl: logoUri!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.memory(kTransparentImage),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Flex(
            direction: Axis.vertical,
            spacing: AppGap.kMediumGap,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(storeName ?? "N/A", style: AppFont.textLarge(context)),
              Flex(
                direction: Axis.horizontal,
                spacing: 5,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.locationDot,
                    size: 20,
                    color: AppColor.kDarkColor,
                  ),
                  Text(
                    storeAddress ?? "N/A",
                    style: AppFont.textMedium(context)
                        .copyWith(color: AppColor.kLightColor),
                  ),
                ],
              ),
              Flex(
                direction: Axis.horizontal,
                spacing: 5,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidSun,
                    size: 20,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    "4.5",
                    style: AppFont.textSmall(context)
                        .copyWith(color: AppColor.kSixthColor),
                  ),
                  const Gap(AppGap.kLargeGap),
                  const FaIcon(
                    FontAwesomeIcons.certificate,
                    size: 20,
                    color: Colors.blueGrey,
                  ),
                  Text(
                    "Beginner",
                    style: AppFont.textSmall(context)
                        .copyWith(color: AppColor.kSixthColor),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
