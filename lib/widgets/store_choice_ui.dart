import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';

final List<Map<String, dynamic>> storeVerify = [
  {
    "verifyStatus": "All",
    "verifyIcon": FontAwesomeIcons.arrowsUpDownLeftRight,
    "color": Colors.lightBlue,
  },
  {
    "verifyStatus": "Verified",
    "verifyIcon": FontAwesomeIcons.clipboardCheck,
    "color": Colors.blueGrey,
  },
  {
    "verifyStatus": "Under Review",
    "verifyIcon": FontAwesomeIcons.hourglassHalf,
    "color": Colors.orangeAccent,
  },
  {
    "verifyStatus": "Terminated",
    "verifyIcon": FontAwesomeIcons.ban,
    "color": Colors.blue,
  },
];

class StoreChoiceUi extends StatefulWidget {
  const StoreChoiceUi({super.key, required this.onSelected});

  final Function(String selected) onSelected;

  @override
  State<StoreChoiceUi> createState() => _StoreChoiceUiState();
}

class _StoreChoiceUiState extends State<StoreChoiceUi> {
  String selected = "All";
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          children: [
            for (final verify in storeVerify)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActionChip(
                  label: Text(
                    verify['verifyStatus'],
                    style: AppFont.textSmall(context),
                  ),
                  backgroundColor: selected == verify['verifyStatus']
                      ? Colors.grey
                      : AppColor.kSixthColor,
                  elevation: 5,
                  padding: const EdgeInsets.all(AppGap.kNormalGap),
                  avatar: CircleAvatar(
                    backgroundColor: verify['color'],
                    radius: 20,
                    child: Icon(
                      verify['verifyIcon'],
                      size: 15,
                      color: AppColor.kSixthColor,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selected = verify['verifyStatus'];
                      widget.onSelected(selected);
                      return;
                    });
                  },
                ),
              ),
          ],
        ),
      ],
    );
  }
}
