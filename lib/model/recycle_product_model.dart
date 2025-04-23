import 'package:wcycle_admin_panel/model/store_model.dart';

class RecycleProductModel {
  RecycleProductModel(
      {required this.impactLevel,
      required this.productImage,
      required this.productOnline,
      required this.shopID,
      required this.productPrice,
      required this.productName,
      this.storeData});

  late final String impactLevel;
  late final String productImage;
  late final bool productOnline;
  late final String shopID;
  late final double productPrice;
  late final String productName;
  StoreModel? storeData;

  RecycleProductModel.fromJson(dynamic json) {
    impactLevel = json['impactLevel'] ?? "N/A";
    productImage = json['productImage'] ?? "N/A";
    productOnline = json['productOnline'] ?? "N/A";
    shopID = json['shopID'] ?? "N/A";
    productPrice = json['productPrice'] ?? "N/A";
    productName = json['productName'] ?? "N/A";
    storeData = json['storeData'] != null
        ? StoreModel.fromJson(json['storeData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['impactLevel'] = impactLevel;
    data['productImage'] = productImage;
    data['productOnline'] = productOnline;
    data['shopID'] = shopID;
    data['productPrice'] = productPrice;
    data['productName'] = productName;
    if (storeData != null) {
      data['storeData'] = storeData?.toJson();
    }
    return data;
  }
}
