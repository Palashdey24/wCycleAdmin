import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/model/event_model.dart';
import 'package:wcycle_admin_panel/shimmer/lt_shimmer.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/events_list_item.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  static const pageConfig =
      PageConfig(pageName: "event_page", child: EventsPage());

  @override
  Widget build(BuildContext context) {
    List<EventModel> eventListData = [];
    return Card(
      color: AppColor.kSixthColor.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(DeviceSize.getDeviceWidth(context) * 0.02)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          spacing: AppGap.kNormalGap,
          children: [
            const Gap(csGap),
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "News",
                  style: AppFont.textMedium(context)
                      .copyWith(color: AppColor.kSecondColor),
                ),
                Flex(
                  direction: Axis.horizontal,
                  spacing: AppGap.kNormalGap,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.navigate_before_rounded,
                          color: AppColor.kLightColor,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.navigate_next_rounded,
                          color: AppColor.kLightColor,
                        )),
                  ],
                )
              ],
            ),
            const Gap(AppGap.kNormalGap),
            SizedBox(
              height: DeviceSize.getDeviceHeight(context) - bottomGap,
              child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection("events").get(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox(
                          height: 150,
                          child: LtShimmer(),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final newsData = snapshot.data!.docs;
                        //Add data to model list one after one
/*                        litteredDataList = litteredData.map((e) {
                          return LitteredModel.fromJson(e.data());
                        }).toList();*/
                        eventListData = newsData.map(
                          (e) {
                            return EventModel.fromJson(e.data());
                          },
                        ).toList();
                    }
                    return GridView.builder(
                      itemCount: eventListData!.length,
                      itemBuilder: (context, index) {
                        return EventsListItem(
                            eventsModel: eventListData[index]);
                      },
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              childAspectRatio: 1,
                              mainAxisSpacing: AppGap.kLargeGap,
                              crossAxisSpacing: AppGap.kLargeGap),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
