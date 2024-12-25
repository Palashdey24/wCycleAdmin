import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/data/side_list_data.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/providers/positions_switcher/switch_drawer_provider.dart';

import 'package:wcycle_admin_panel/utlits/string.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/sidebar_item.dart';

final fontHelper = FontHelper();
final apis = Apis();

class LeftSider extends ConsumerWidget {
  const LeftSider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onDrawer = ref.watch(swichDrawerProviders);
    return SizedBox(
      width: onDrawer ? apis.deviceWidth(context) * 0.20 : 100,
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
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
                    style: fontHelper.bodyLarge(context),
                  ),
                )
              ],
            ),
            const Gap(largeGap),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            for (final sideitems in sideListData)
              SidebarItem(
                ltTitle: sideitems.ltTitle,
                faIcon: sideitems.faIcon,
                color: sideitems.color,
                isActive: sideitems.isActive,
                ltPost: sideitems.ltPositon,
              )
          ],
        ),
      ),
    );
  }
}
