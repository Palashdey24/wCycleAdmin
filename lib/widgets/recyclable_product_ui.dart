import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';
import 'package:wcycle_admin_panel/widgets/recyclable_list_item_info.dart';

class RecyclableProductUi extends StatelessWidget {
  const RecyclableProductUi({super.key, this.rcListModel});

  final RecycleProductModel? rcListModel;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Stack(
          children: [
            SizedBox(
              width: 270,
              height: 260,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 55),
                    width: 250,
                    height: 240,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.yellowAccent.withOpacity(0.4),
                        Colors.blueGrey,
                      ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(60),
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: rcListModel != null
                        ? RecyclableListItemInfo(rcListModel: rcListModel!)
                        : null,
                  ),
                  Positioned(
                      top: 0,
                      left: 30,
                      child: Transform.rotate(
                        angle: 0.2,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 65,
                          child: rcListModel?.productImage != null
                              ? Image.network(
                                  rcListModel!.productImage,
                                  fit: BoxFit.contain,
                                )
                              : null,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
