import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  static const pageConfig =
      PageConfig(pageName: "event_page", child: EventsPage());

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "hello",
        style: TextStyle(color: Colors.black, fontSize: 30),
      ),
    );
  }
}
