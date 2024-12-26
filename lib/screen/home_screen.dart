import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';

import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/page/add/add_events_items.dart';
import 'package:wcycle_admin_panel/page/add/add_littered_spot_items.dart';
import 'package:wcycle_admin_panel/page/add/add_recyclecategory.dart';
import 'package:wcycle_admin_panel/page/dashboard_page.dart';
import 'package:wcycle_admin_panel/page/littered_spot_page.dart';
import 'package:wcycle_admin_panel/page/recycle_page.dart';

import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/center_sider.dart';
import 'package:wcycle_admin_panel/widgets/left_sider.dart';
import 'package:wcycle_admin_panel/providers/positions_switcher/active_positions_providers.dart';

final apis = Apis();
final fontHelper = FontHelper();

final addPages = [
  AddRecycableCategory.pageConfig,
  AddLitteredSpotItems.pageConfig,
  AddEventsItems.pageConfig,
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, String? tab});

  static const pageConfig = PageConfig(pageName: "home", child: HomeScreen());

  void onAddBtn(int actPosition, BuildContext context) {
    context.pushNamed(addPages[actPosition - 1].pageName);
  }

  static final pages = [
    DashboardPage.pageConfig,
    RecyclePage.pageConfig,
    EventsPage.pageConfig,
    RecyclePage.pageConfig,
    EventsPage.pageConfig,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actPositions = ref.watch(actPagePosProviders);

    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => onAddBtn(actPositions, context),
        child: AnimatedOpacity(
          opacity: actPositions != 0 ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: const CircleAvatar(
            maxRadius: 30,
            child: FaIcon(
              FontAwesomeIcons.database,
              color: Colors.green,
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: apis.deviceHeight(context),
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Card(
                color: Colors.lightBlue[300],
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(csGap))),
              ),
            ),
            Positioned(
                top: 10,
                child: SizedBox(
                  width: apis.deviceWidth(context),
                  height: apis.deviceHeight(context),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: largeGap, top: largeGap),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        const LeftSider(),
                        CenterSider(slidePage: pages[actPositions].child),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
