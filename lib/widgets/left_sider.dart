import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';
import 'package:wcycle_admin_panel/data/side_list_data.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/providers/positions_switcher/switch_drawer_provider.dart';
import 'package:wcycle_admin_panel/utlits/string.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/left_sider_profile.dart';
import 'package:wcycle_admin_panel/widgets/sidebar_item.dart';

final fontHelper = FontHelper();
final apis = Apis();

class LeftSider extends ConsumerWidget {
  const LeftSider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onDrawer = ref.watch(swichDrawerProviders);
    final deviceHeight = DeviceSize.getDeviceHeight(context);
    final deviceWidth = apis.deviceWidth(context);

    return SizedBox(
      width: onDrawer ? apis.deviceWidth(context) * 0.15 : 100,
      child: Padding(
        padding: EdgeInsets.only(bottom: deviceHeight * 0.02),
        child: Stack(
          children: [
            Card(
              elevation: 3,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.all(0),
              color: AppColor.kSixthColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(deviceWidth * 0.02)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppGap.kNormalGap),
                child: Column(
                  children: [
                    const Gap(csGap),
                    Row(
                      children: [
                        const Gap(csGap),
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(appLogo),
                        ),
                        const Gap(5),
                        Visibility(
                          visible: onDrawer,
                          child: Text(
                            "No waste",
                            style: AppFont.textMedium(context),
                          ),
                        )
                      ],
                    ),
                    const Gap(AppGap.kLargeGap),
                    const Divider(
                      thickness: 2,
                      height: 2,
                    ),
                    const Gap(AppGap.kMediumGap),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pages",
                        style: AppFont.textSmall(context),
                      ),
                    ),
                    const Gap(AppGap.kMediumGap),
                    Expanded(
                      child: ListView(
                        children: [
                          for (final sideitems in sideListData)
                            SidebarItem(
                              ltTitle: sideitems.ltTitle,
                              faIcon: sideitems.faIcon,
                              color: sideitems.color,
                              isActive: sideitems.isActive,
                              ltPost: sideitems.ltPositon,
                            ),
                          if (onDrawer && deviceHeight <= 800)
                            const Align(
                                alignment: Alignment.bottomCenter,
                                child: LeftSiderProfile()),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (onDrawer && deviceHeight >= 800)
              const Positioned(
                bottom: 0,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: LeftSiderProfile()),
              )
          ],
        ),
      ),
    );
  }
}
