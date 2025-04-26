import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';
import 'package:wcycle_admin_panel/model/event_model.dart';
import 'package:wcycle_admin_panel/widgets/even_date_show.dart';
import 'package:wcycle_admin_panel/widgets/events_list_item_info.dart';

class EventsListItem extends StatelessWidget {
  const EventsListItem({super.key, this.isVertical, required this.eventsModel});

  final EventModel eventsModel;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 8, top: 5),
              clipBehavior: Clip.hardEdge,
              width: isVertical != null
                  ? (DeviceSize.getDeviceWidth(context) / 1)
                  : (DeviceSize.getDeviceWidth(context) / 1.7),
              decoration: const BoxDecoration(
                color: AppColor.kSecondColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: EventsListItemInfo(eventList: eventsModel)),
          Positioned(
              top: 0,
              left: 20,
              child: Row(
                spacing: 2,
                children: [
                  EvenDateShow(
                      dmyTxt:
                          " ${DeviceSize.getDeviceHeight(context).toString()}"),
                  const EvenDateShow(dmyTxt: "Dec"),
                  const EvenDateShow(dmyTxt: "24"),
                ],
              )),
        ],
      ),
    );
  }
}
