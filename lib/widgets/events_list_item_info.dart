import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/model/event_model.dart';

class EventsListItemInfo extends StatelessWidget {
  const EventsListItemInfo({super.key, required this.eventList});

  final EventModel eventList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          eventList.ltSrc!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0, left: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eventList.eventsTittle!,
                style: FontHelper().bodySmall(context),
              ),
              const Gap(2),
              Text(
                textAlign: TextAlign.left,
                softWrap: true,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                eventList.eventsDescription!,
                style: GoogleFonts.lato(
                  fontSize: 8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    eventList.eventsInterested!.toString(),
                    style: FontHelper().bodySmall(context),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.blue,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
