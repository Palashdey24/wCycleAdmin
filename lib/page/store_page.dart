import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wcycle_admin_panel/core/dimensions/app_gap.dart';
import 'package:wcycle_admin_panel/core/page_config.dart';
import 'package:wcycle_admin_panel/model/store_model.dart';
import 'package:wcycle_admin_panel/page/store_profile_page.dart';
import 'package:wcycle_admin_panel/shimmer/store_ui_shimmer.dart';
import 'package:wcycle_admin_panel/widgets/store_choice_ui.dart';
import 'package:wcycle_admin_panel/widgets/store_item.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  static const pageConfig = PageConfig(pageName: "store", child: StorePage());
  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> selecteVerify = ValueNotifier<String>("All");

    List<StoreModel> storeDataList = [];

    return ValueListenableBuilder(
      valueListenable: selecteVerify,
      builder: (context, value, child) => Column(
        spacing: AppGap.kMediumGap,
        children: [
          StoreChoiceUi(onSelected: (selected) {
            selecteVerify.value = selected;
          }),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("store").get(),
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
                  final storeData = snapshot.data!.docs;
                  //Add data to model list one after one
                  storeDataList = storeData
                      .map(
                        (e) => StoreModel.fromJson(e.data()),
                      )
                      .toList();

                  final storeFiltered = selecteVerify.value == "All"
                      ? storeDataList
                      : storeDataList.where(
                          (element) {
                            return element.storeStatus == selecteVerify.value;
                          },
                        ).toList();
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300),
                      itemCount: storeFiltered.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.pushReplacementNamed(
                                StoreProfilePage.pageConfig.pageName,
                                extra: storeFiltered[index]);
                          },
                          child: StoreItem(
                            storeImage: storeFiltered[index].logoUri,
                            storeLocation: storeFiltered[index].storeAddress,
                            storeName: storeFiltered[index].storeName,
                            storeStatus: storeFiltered[index].storeStatus,
                          ),
                        );
                      },
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
