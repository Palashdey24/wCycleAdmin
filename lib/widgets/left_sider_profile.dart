import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';

class LeftSiderProfile extends StatelessWidget {
  const LeftSiderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = DeviceSize.getDeviceHeight(context);
    final deviceWidth = DeviceSize.getDeviceWidth(context);
    return SizedBox(
      height: deviceHeight * 0.25,
      width: deviceWidth * 0.15,
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.only(
              top: deviceHeight * 0.05,
              left: deviceWidth * 0.01,
              right: deviceWidth * 0.01,
              bottom: deviceHeight * 0.01,
            ),
            elevation: 3,
            color: AppColor.kDarkColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppGap.kLargeGap)),
            ),
            child: Flex(
              direction: Axis.vertical,
              spacing: AppGap.kMediumGap,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bijoy Banik",
                  style: AppFont.textMedium(context),
                ),
                Text(
                  "Admin",
                  style: AppFont.textSmall(context),
                  textAlign: TextAlign.center,
                ),
                const Row(
                  spacing: AppGap.kNormalGap,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      child: Icon(Icons.settings),
                    ),
                    CircleAvatar(
                      radius: 15,
                      child: Icon(Icons.logout),
                    ),
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: const CircleBorder(),
              child: Image.asset(
                height: deviceHeight * 0.07,
                width: deviceHeight * 0.07,
                "assets/industrialGarbage.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
