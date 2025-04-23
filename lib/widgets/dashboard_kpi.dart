import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';

final fonthelpers = FontHelper();
final api = Apis();

class DashboardKpi extends StatelessWidget {
  const DashboardKpi({super.key, this.kpiTitle, this.kpiValue, this.kpiChange});

  final String? kpiTitle;
  final String? kpiValue;
  final String? kpiChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (api.deviceWidth(context) * 0.80) / 4.5,
      child: Card(
        elevation: 10,
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: const BorderSide(
                color: Color.fromARGB(202, 221, 233, 15), width: 4)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(kpiTitle ?? "Today Money",
                        style: fonthelpers
                            .bodyLarge(context)
                            .copyWith(color: Colors.white)),
                    const Gap(normalGap + 5),
                    Text(
                      kpiValue == null ? "\$43,999" : "$kpiValue",
                      style: fonthelpers
                          .bodyLarge(context)
                          .copyWith(color: Colors.orange),
                    ),
                    const Gap(normalGap + 10),
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 18, color: Colors.green),
                        text: kpiChange ?? "+55%",
                        children: const [
                          TextSpan(text: "Since Yesterday "),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Expanded(
                flex: 20,
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  maxRadius: 35,
                  child: FaIcon(
                    FontAwesomeIcons.usersRectangle,
                    color: Colors.deepOrange,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
