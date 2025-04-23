import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/dashboard_kpi.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const pageConfig =
      PageConfig(pageName: "dashboard", child: DashboardPage());
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            DashboardKpi(),
            Gap(normalGap),
            DashboardKpi(
              kpiChange: "+55%",
              kpiTitle: "Total Store",
              kpiValue: "10",
            ),
            Gap(normalGap),
            DashboardKpi(),
            Gap(normalGap),
          ],
        )
      ],
    );
  }
}
