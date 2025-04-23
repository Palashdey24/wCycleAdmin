import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';
import 'package:wcycle_admin_panel/widgets/store_profie/store_recyclable_list_item_info.dart';

class StoreRecyclableListItem extends StatelessWidget {
  const StoreRecyclableListItem({
    super.key,
    this.rcListModel,
    this.isDtPage,
  });

  final RecycleProductModel? rcListModel;
  final bool? isDtPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 140,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 20),
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.yellowAccent.withValues(alpha: 0.4),
                      Colors.blueGrey,
                    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: rcListModel != null
                      ? StoreRecyclableListItemInfo(rcListModel: rcListModel!)
                      : null,
                ),
              ),
              Positioned(
                  top: 0,
                  left: 10,
                  child: Transform.rotate(
                    angle: 0.5,
                    child: CircleAvatar(
                      backgroundColor: rcListModel != null
                          ? Colors.transparent
                          : Colors.white,
                      radius: 29,
                      child: rcListModel != null
                          ? FadeInImage(
                              placeholder: MemoryImage(kTransparentImage),
                              image: NetworkImage(rcListModel!.productImage))
                          : null,
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
