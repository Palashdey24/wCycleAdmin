import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';
import 'package:wcycle_admin_panel/shimmer/store_ui_shimmer.dart';

class Checking extends StatelessWidget {
  const Checking({super.key});

  @override
  Widget build(BuildContext context) {
    List<RecycleProductModel> storeRecycleList = [];

    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("checking").get(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const SizedBox(
              height: 200,
              child: StoreUiShimmer(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            final recycleData = snapshot.data!.docs;
            //Add data to model list one after one

            //getStoreData(recycleData[0].data()['storeData']);

            return recycleData.isNotEmpty
                ? Center(
                    child: Text(
                      "Store Data:",
                      style: AppFont.textMedium(context)
                          .copyWith(color: Colors.red),
                    ),
                  )
                : Center(
                    child: Text(
                      "Store Not Add Product Yet",
                      style: AppFont.textMedium(context)
                          .copyWith(color: Colors.red),
                    ),
                  );
        }
      },
    );
  }
}
