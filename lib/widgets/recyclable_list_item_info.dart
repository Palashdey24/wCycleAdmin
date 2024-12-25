import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/helper/dialogs_helper.dart';
import 'package:wcycle_admin_panel/helper/font_helper.dart';
import 'package:wcycle_admin_panel/model/recyclable_list_model.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';

final fontHelpers = FontHelper();

class RecyclableListItemInfo extends StatelessWidget {
  const RecyclableListItemInfo({super.key, required this.rcListModel});

  final RecycleProductModel rcListModel;

  @override
  Widget build(BuildContext context) {
    final themes = Theme.of(context).textTheme;
    final RecycleProductModel(
      :productName,
      :impactLevel,
      :productPrice,
      :productOnline
    ) = rcListModel;
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 55,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Card(
              color: const Color.fromARGB(208, 26, 41, 65),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              margin: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    productOnline.toString(),
                    style: fontHelpers
                        .bodyMedium(context)
                        .copyWith(color: Colors.lightBlueAccent),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    productName,
                    style: themes.labelLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  Text(
                    textAlign: TextAlign.center,
                    "Level: $impactLevel",
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const Gap(10),
                ],
              ),
              Container(
                width: 55,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(208, 4, 13, 5),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10))),
                child: Text(
                  textAlign: TextAlign.left,
                  "\$${productPrice}",
                  style: themes.labelMedium!
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
