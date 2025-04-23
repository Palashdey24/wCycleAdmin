import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/model/littered_model.dart';
import 'package:wcycle_admin_panel/widgets/waste_material_chips.dart';

final fontHelper = FontHelper();

class LitteredListItemInfo extends StatelessWidget {
  const LitteredListItemInfo(
      {super.key, required this.ltList, this.isVertical});

  final LitteredModel ltList;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    String? combainWcat;
    for (final wcat in ltList.litteredWasteMat) {
      if (combainWcat == null) {
        combainWcat = wcat;
      } else {
        combainWcat = "$combainWcat-$wcat";
      }
    }

    final themes = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 70.0, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: AppGap.kNormalGap,
        children: [
          Text(
            ltList.litteredTittle,
            style: themes.titleSmall!.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(
                Icons.place,
                color: Colors.blueGrey,
              ),
              Flexible(
                child: Text(
                  textAlign: TextAlign.right,
                  maxLines: 5,
                  softWrap: true,
                  "${ltList.litteredVillMet}, ${ltList.litteredThana}, ${ltList.litteredDivision}",
                  style: AppFont.textSmall(context),
                ),
              ),
            ],
          ),
          Flexible(
            child: Text(
              "Status: ${ltList.productOnline} ",
              maxLines: 4,
              textAlign: TextAlign.right,
              style: AppFont.textSmall(context)
                  .copyWith(color: AppColor.kSecondColor),
            ),
          ),
          Text(
            "Level: ${ltList.litteredImpactLevel.toUpperCase()}",
            style: AppFont.textSmall(context),
          ),
          WasteMaterialChips(ltWCat: ltList.litteredWasteMat),
        ],
      ),
    );
  }
}
