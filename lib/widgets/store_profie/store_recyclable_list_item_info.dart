import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';

class StoreRecyclableListItemInfo extends StatelessWidget {
  const StoreRecyclableListItemInfo({super.key, required this.rcListModel});

  final RecycleProductModel rcListModel;

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              textAlign: TextAlign.center,
              rcListModel.productName,
              style: AppFont.textMedium(context),
            ),
            const Gap(5),
            Text(
              textAlign: TextAlign.center,
              "Level: ${rcListModel.impactLevel}",
              maxLines: 2,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const Gap(5),
            const Text(
              textAlign: TextAlign.center,
              "Rating",
              maxLines: 2,
              style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 27, 37, 16)),
            ),
            const Gap(10),
          ],
        ),
        Container(
          width: 45,
          decoration: const BoxDecoration(
              color: Color.fromARGB(208, 4, 13, 5),
              borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
          child: Text(
            textAlign: TextAlign.left,
            "\$${rcListModel.productPrice}",
            style: themes.labelMedium!.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
