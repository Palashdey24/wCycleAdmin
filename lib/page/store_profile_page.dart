import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:wcycle_admin_panel/checking2.dart';
import 'package:wcycle_admin_panel/config/theme/app_color.dart';
import 'package:wcycle_admin_panel/config/theme/app_font.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/core/dimensions/device_size.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/model/recycle_product_model.dart';
import 'package:wcycle_admin_panel/model/store_model.dart';
import 'package:wcycle_admin_panel/shimmer/store_ui_shimmer.dart';
import 'package:wcycle_admin_panel/widgets/store_profie/document_view.dart';
import 'package:wcycle_admin_panel/widgets/store_profie/store_profile_feature_list_ui.dart';
import 'package:wcycle_admin_panel/widgets/store_profie/store_profile_intro.dart';
import 'package:wcycle_admin_panel/widgets/store_profie/store_recyclable_list_item.dart';

import '../helper/dialogs_helper.dart';

class StoreProfilePage extends StatelessWidget {
  const StoreProfilePage({
    super.key,
    this.storeModel,
  });

  static const pageConfig =
      PageConfig(pageName: "storeProfile", child: StoreProfilePage());

  final StoreModel? storeModel;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = DeviceSize.getDeviceWidth(context);
    final deviceHeight = DeviceSize.getDeviceHeight(context);
    File loadFiles = File("path");

    List<RecycleProductModel> storeRecycleList = [];

    FutureOr<Uint8List> getUri() async {
      const url =
          "https://file-examples.com/wp-content/storage/2017/10/file-sample_150kB.pdf";
      final Uint8List content;
      final file = await https.get(Uri.parse(url));
      return content = file.bodyBytes;
    }

    Widget productSection() {
      void data() async {
        final referenceCheck = await FirebaseFirestore.instance
            .collection("checking")
            .doc(storeModel!.id)
            .get()
            .then(
          (value) {
            final storeData = value.data();
            if (!context.mounted) return;
            DialogsHelper.showMessage(
                context, storeData?['storeData'].toString() ?? "N/A");
          },
        );
      }

      return FutureBuilder(
        future: FirebaseFirestore.instance.collection("recycleProduct").get(),
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
              storeRecycleList = recycleData
                  .map(
                    (e) => RecycleProductModel.fromJson(e.data()),
                  )
                  .toList();

              final recycleFiltered = storeRecycleList.where(
                (element) {
                  return element.shopID == storeModel!.id;
                },
              ).toList();

              return recycleFiltered.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300),
                      itemCount: recycleFiltered.length,
                      itemBuilder: (context, index) {
                        return StoreRecyclableListItem(
                          rcListModel: recycleFiltered[index],
                        );
                      },
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

    final List<Widget> centerWidgets = [
      productSection(),
      DocumentView(
        content: getUri(),
        getUri: storeModel!.docUri!,
      ),
      const Checking(),
    ];

    ValueNotifier<int> centerIndex = ValueNotifier<int>(0);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(50),
        children: [
          StoreProfileIntro(
            storeModel: storeModel!,
          ),
          ValueListenableBuilder(
            valueListenable: centerIndex,
            builder: (context, value, child) => Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppGap.kMediumGap),
                  width: deviceWidth * 0.3,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.kSecondColor)),
                  child: StoreProfileFeatureListUi(
                    storeRecycleLength: storeRecycleList.length,
                    storeModel: storeModel!,
                    stopWebview: () => centerIndex.value = 0,
                    onPressedTittle: (tittle) {
                      if (tittle == "Products") {
                        centerIndex.value = 0;
                      } else if (tittle == "Document") {
                        centerIndex.value = 1;
                      } else {
                        centerIndex.value = 2;
                      }
                    },
                  ),
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  height: deviceHeight - 210,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.kSecondColor)),
                  child: IndexedStack(
                    index: centerIndex.value,
                    children: centerWidgets,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
