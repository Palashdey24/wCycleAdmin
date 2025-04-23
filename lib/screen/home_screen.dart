import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/page/add/add_events_items.dart';
import 'package:wcycle_admin_panel/page/add/add_littered_spot_items.dart';
import 'package:wcycle_admin_panel/page/add/add_news.dart';
import 'package:wcycle_admin_panel/page/add/add_recyclecategory.dart';
import 'package:wcycle_admin_panel/page/dashboard_page.dart';
import 'package:wcycle_admin_panel/page/littered_spot_page.dart';
import 'package:wcycle_admin_panel/page/news_page.dart';
import 'package:wcycle_admin_panel/page/recycle_page.dart';
import 'package:wcycle_admin_panel/page/store_page.dart';
import 'package:wcycle_admin_panel/providers/positions_switcher/active_positions_providers.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/center_sider.dart';
import 'package:wcycle_admin_panel/widgets/left_sider.dart';

final apis = Apis();
final fontHelper = FontHelper();

final addPages = [
  AddRecycableCategory.pageConfig,
  AddLitteredSpotItems.pageConfig,
  AddEventsItems.pageConfig,
];

final addSections = [
  const AddRecycableCategory(),
  const AddLitteredSpotItems(),
  const AddEventsItems(),
  const AddNews()
];

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, String? tab});

  static const pageConfig = PageConfig(pageName: "home", child: HomeScreen());

  void onAddBtn(int actPosition, BuildContext context) {
    context.replaceNamed(addPages[actPosition - 1].pageName);
  }

  static final pages = [
    DashboardPage.pageConfig,
    RecyclePage.pageConfig,
    LitteredSpotPage.pageConfig,
    RecyclePage.pageConfig,
    NewsPage.pageConfig,
    StorePage.pageConfig,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actPositions = ref.watch(actPagePosProviders);
    final deviceHeight = apis.deviceHeight(context);
    final deviceWidth = apis.deviceWidth(context);

    return Scaffold(
      floatingActionButton: deviceWidth < 1200
          ? InkWell(
              onTap: () => onAddBtn(actPositions, context),
              child: AnimatedOpacity(
                opacity: (actPositions != 0 && actPositions != 5) ? 1.0 : 0.0,
                duration: const Duration(seconds: 1),
                child: const CircleAvatar(
                  maxRadius: 30,
                  child: FaIcon(
                    FontAwesomeIcons.database,
                    color: Colors.green,
                  ),
                ),
              ),
            )
          : null,
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
            SizedBox(
              width: apis.deviceWidth(context),
              height: apis.deviceHeight(context),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: largeGap, top: largeGap * 2),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    const LeftSider(),
                    SingleChildScrollView(
                      child: SizedBox(
                          height: deviceHeight,
                          width: (actPositions > 0 &&
                                  actPositions != 5 &&
                                  deviceWidth > 1300)
                              ? deviceWidth * 0.5
                              : deviceWidth * 0.8,
                          child: CenterSider(
                              slidePage: pages[actPositions].child)),
                    ),
                    if (actPositions > 0 &&
                        actPositions != 5 &&
                        deviceWidth >= 1300)
                      Expanded(
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          color: Colors.transparent,
                          margin: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(deviceWidth * 0.02),
                              side: const BorderSide(
                                  color: AppColor.kSecondColor, width: 2)),
                          child: IndexedStack(
                            index: actPositions - 1,
                            children: addSections,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
