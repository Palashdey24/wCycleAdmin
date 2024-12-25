import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_admin_panel/api/apis.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/data/recycable_price_data.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';
import 'package:wcycle_admin_panel/shimmer/recycle_shimmer.dart';
import 'package:wcycle_admin_panel/utlits/style.dart';
import 'package:wcycle_admin_panel/widgets/recyclable_list_item.dart';

final apis = Apis();

class RecyclePage extends StatelessWidget {
  const RecyclePage({super.key});

  static const pageConfig =
      PageConfig(pageName: "recycle_page", child: RecyclePage());

  @override
  Widget build(BuildContext context) {
    List<RecycleProductModel> recycleDataList = [];
    return Column(
      children: [
        const Gap(csGap),
        SizedBox(
          width: apis.deviceWidth(context) * 0.7,
          height: apis.deviceHeight(context) - 200,
          child: FutureBuilder(
              future:
                  FirebaseFirestore.instance.collection("recycleProduct").get(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const SizedBox(
                      height: 150,
                      child: RecycleShimmer(),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final recycleData = snapshot.data!.docs;
                    //Add data to model list one after one
                    recycleDataList = recycleData
                        .map(
                          (e) => RecycleProductModel.fromJson(e.data()),
                        )
                        .toList();
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 350),
                  itemCount: recycleDataList.length,
                  itemBuilder: (context, index) {
                    return RecyclableListItem(
                        rcListModel: recycleDataList[index]);
                  },
                );
              }),
        )
      ],
    );
  }
}
