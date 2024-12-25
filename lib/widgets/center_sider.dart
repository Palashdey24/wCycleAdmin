import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/data/side_list_data.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/page/add/add_recyclecategory.dart';
import 'package:wcycle_admin_panel/page/dashboard_page.dart';
import 'package:wcycle_admin_panel/page/littered_spot_page.dart';
import 'package:wcycle_admin_panel/page/recycle_page.dart';
import 'package:wcycle_admin_panel/providers/positions_switcher/active_positions_providers.dart';
import 'package:wcycle_admin_panel/providers/positions_switcher/switch_drawer_provider.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';

final apis = Apis();
final fontHelper = FontHelper();

class CenterSider extends ConsumerWidget {
  const CenterSider({
    super.key,
    required this.slidePage,
  });

  final Widget slidePage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onDrawer = ref.watch(swichDrawerProviders);
    final actPosition = ref.watch(actPagePosProviders);

    final onDrawerFn = ref.read(swichDrawerProviders.notifier);
    return Padding(
      padding: const EdgeInsets.only(left: largeGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(largeGap),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FaIcon(
                    sideListData[actPosition].faIcon,
                    color: Colors.yellow,
                    size: 25,
                  ),
                  Text(
                    sideListData[actPosition].ltTitle,
                    style: fontHelper
                        .bodyLarge(context)
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              const Gap(csGap),
              IconButton(
                onPressed: () => onDrawerFn.onChangeDrawer(onDrawer),
                icon: FaIcon(
                  onDrawer
                      ? FontAwesomeIcons.shuffle
                      : FontAwesomeIcons.maximize,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
          const Gap(largeGap + 30),
          slidePage,
        ],
      ),
    );
  }
}
