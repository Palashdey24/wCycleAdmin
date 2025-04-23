import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';
import 'package:wcycle_admin_panel/providers/positions_switcher/active_positions_providers.dart';
import 'package:wcycle_admin_panel/providers/positions_switcher/switch_drawer_provider.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';

final api = Apis();

class SidebarItem extends ConsumerWidget {
  const SidebarItem({
    super.key,
    required this.ltTitle,
    required this.faIcon,
    required this.color,
    required this.isActive,
    required this.ltPost,
  });

  final String ltTitle;
  final IconData faIcon;
  final Color color;
  final bool isActive;
  final int ltPost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actPositions = ref.watch(actPagePosProviders);
    final onDrawer = ref.watch(swichDrawerProviders);
    final actPosFn = ref.read(actPagePosProviders.notifier);
    bool isActive = ltPost == actPositions;

    final deviceWidth = DeviceSize.getDeviceWidth(context);

    return InkWell(
      hoverColor: Colors.grey,
      onTap: () => actPosFn.changeActivePostions(ltPost, context),
      child: Stack(
        children: [
          AnimatedPositioned(
              duration: onDrawer
                  ? const Duration(seconds: 1)
                  : const Duration(milliseconds: 500),
              top: 0,
              height: 80,
              width: isActive ? deviceWidth * 0.15 - AppGap.kNormalGap : 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[500],
                ),
              )),
          SizedBox(
            height: 80,
            child: Row(
              children: [
                const Gap(5),
                FaIcon(
                  faIcon,
                  color: color,
                  size: 25,
                ),
                const Gap(largeGap),
                Text(onDrawer ? ltTitle : " ",
                    style: AppFont.textSmall(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
