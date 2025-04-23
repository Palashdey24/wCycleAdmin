import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';

class StoreItem extends StatelessWidget {
  const StoreItem(
      {super.key,
      this.storeName,
      this.storeLocation,
      this.storeImage,
      this.storeStatus});

  final String? storeName;
  final String? storeLocation;
  final String? storeImage;
  final String? storeStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.kDarkColor.withValues(alpha: 0.7),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppGap.kNormalGap))),
      margin: const EdgeInsets.symmetric(
          vertical: AppGap.kNormalGap, horizontal: AppGap.kNormalGap),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.vertical,
          spacing: AppGap.kNormalGap,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 75,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: storeImage == null
                  ? Image.memory(kTransparentImage)
                  : CachedNetworkImage(
                      imageUrl: storeImage!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Image.memory(kTransparentImage),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
            Text(
              storeName ?? "Loading",
              style: AppFont.textMedium(context),
            ),
            Text(
              storeLocation ?? "",
              style: AppFont.textSmall(context),
            ),
            Text(
              storeStatus ?? "",
              textScaler: const TextScaler.linear(0.2),
              style: AppFont.tittleStyleFirst(context),
            ),
          ],
        ),
      ),
    );
  }
}
