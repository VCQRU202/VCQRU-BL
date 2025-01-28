class GiftModel {
  bool? success;
  String? message;
  Data? data;

  GiftModel({this.success, this.message, this.data});

  GiftModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Rows>? rows;
  List<CashData>? cashData;
  List<Banners>? banners;
  Data({this.rows, this.cashData,this.banners});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      rows = <Rows>[];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
      });
    }
    if (json['cashData'] != null) {
      cashData = <CashData>[];
      json['cashData'].forEach((v) {
        cashData!.add(new CashData.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    if (this.cashData != null) {
      data['cashData'] = this.cashData!.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rows {
  int? giftId;
  String? giftName;
  int? giftValue;
  String? giftDesc;
  String? giftImage;
  int? status;
  String? compID;
  int? giftPoint;
  List<String>? giftImages;
  int? btnFlag;
  String? giftMessage;
  String? uPIID;
  String? serviceId;
  String? availablePoint;

  Rows(
      {this.giftId,
        this.giftName,
        this.giftValue,
        this.giftDesc,
        this.giftImage,
        this.status,
        this.compID,
        this.giftPoint,
        this.giftImages,
        this.btnFlag,
        this.giftMessage,
        this.uPIID,
        this.availablePoint,
        this.serviceId});

  Rows.fromJson(Map<String, dynamic> json) {
    giftId = json['gift_id'];
    giftName = json['Gift_name'];
    giftValue = json['Gift_value'];
    giftDesc = json['Gift_desc'];
    giftImage = json['Gift_image'];
    status = json['status'];
    compID = json['CompID'];
    giftPoint = json['Gift_point'];
    giftImages = json['gift_images'].cast<String>();
    btnFlag = json['btn_flag'];
    giftMessage = json['gift_message'];
    uPIID = json['UPIID'];
    availablePoint = json['availablePoint'];
    serviceId = json['ServiceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gift_id'] = this.giftId;
    data['Gift_name'] = this.giftName;
    data['Gift_value'] = this.giftValue;
    data['Gift_desc'] = this.giftDesc;
    data['Gift_image'] = this.giftImage;
    data['status'] = this.status;
    data['CompID'] = this.compID;
    data['Gift_point'] = this.giftPoint;
    data['gift_images'] = this.giftImages;
    data['btn_flag'] = this.btnFlag;
    data['gift_message'] = this.giftMessage;
    data['UPIID'] = this.uPIID;
    data['availablePoint'] = this.availablePoint;
    data['ServiceId'] = this.serviceId;
    return data;
  }
}

class CashData {
  String? key;
  String? value;

  CashData({this.key, this.value});

  CashData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Banners {
  String? key;
  String? value;
  String? bannertext1;
  String? bannertext2;
  String? bannertext3;
  String? bannertext4;
  String? text;

  Banners(
      {this.key,
        this.value,
        this.bannertext1,
        this.bannertext2,
        this.bannertext3,
        this.bannertext4,
        this.text});

  Banners.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    bannertext1 = json['bannertext1'];
    bannertext2 = json['bannertext2'];
    bannertext3 = json['bannertext3'];
    bannertext4 = json['bannertext4'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['bannertext1'] = this.bannertext1;
    data['bannertext2'] = this.bannertext2;
    data['bannertext3'] = this.bannertext3;
    data['bannertext4'] = this.bannertext4;
    data['text'] = this.text;
    return data;
  }
}