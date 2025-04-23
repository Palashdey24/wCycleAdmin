class StoreModel {
  StoreModel({
    this.phoneNumber,
    this.storeAddress,
    this.locations,
    this.storeName,
    this.docUri,
    this.logoUri,
    this.id,
    this.email,
    this.storeStatus,
    this.storeBin,
  });

  StoreModel.fromJson(dynamic json) {
    phoneNumber = json['phoneNumber'] ?? "N/A";
    storeAddress = json['storeAddress'] ?? "N/A";
    locations = json['locations'] != null
        ? Locations.fromJson(json['locations'])
        : null;
    storeName = json['storeName'] ?? "N/A";
    docUri = json['docUri'] ?? "N/A";
    logoUri = json['logoUri'] ?? "N/A";
    id = json['id'] ?? "N/A";
    email = json['email'] ?? "N/A";
    storeStatus = json['storeStatus'] ?? "N/A";
    storeBin = json['storeBin'] ?? "N/A";
  }
  String? phoneNumber;
  String? storeAddress;
  Locations? locations;
  String? storeName;
  String? docUri;
  String? logoUri;
  String? id;
  String? email;
  String? storeStatus;
  String? storeBin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneNumber'] = phoneNumber ?? "N/A";
    map['storeAddress'] = storeAddress ?? "N/A";
    if (locations != null) {
      map['locations'] = locations?.toJson();
    }
    map['storeName'] = storeName ?? "N/A";
    map['docUri'] = docUri ?? "N/A";
    map['logoUri'] = logoUri ?? "N/A";
    map['id'] = id ?? "N/A";
    map['email'] = email ?? "N/A";
    map['storeStatus'] = storeStatus ?? "N/A";
    map['storeBin'] = storeBin ?? "N/A";
    return map;
  }
}

class Locations {
  Locations({
    this.address,
    this.lon,
    this.lat,
  });

  Locations.fromJson(dynamic json) {
    address = json['address'] ?? "N/A";
    lon = json['lon'] ?? "N/A";
    lat = json['lat'] ?? "N/A";
  }
  String? address;
  num? lon;
  num? lat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address ?? "N/A";
    map['lon'] = lon ?? "N/A";
    map['lat'] = lat ?? "N/A";
    return map;
  }
}
