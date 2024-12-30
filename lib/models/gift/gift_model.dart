class GiftModel {
  bool? success;
  String? message;
  List<GiftData>? data;

  GiftModel({this.success, this.message, this.data});

  GiftModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GiftData>[];
      json['data'].forEach((v) {
        data!.add(new GiftData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GiftData {
  var giftId;
  String? giftName;
  var giftValue;
  String? giftDesc;
  String? giftImage;
  var status;
  String? compID;
  List<String>? giftImages;
  var btnFlag;
  String? giftMessage;

  GiftData(
      {this.giftId,
        this.giftName,
        this.giftValue,
        this.giftDesc,
        this.giftImage,
        this.status,
        this.compID,
        this.giftImages,
        this.btnFlag,
        this.giftMessage});

  GiftData.fromJson(Map<String, dynamic> json) {
    giftId = json['gift_id'];
    giftName = json['Gift_name'];
    giftValue = json['Gift_value'];
    giftDesc = json['Gift_desc'];
    giftImage = json['Gift_image'];
    status = json['status'];
    compID = json['CompID'];
    giftImages = json['gift_images'].cast<String>();
    btnFlag = json['btn_flag'];
    giftMessage = json['gift_message'];
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
    data['gift_images'] = this.giftImages;
    data['btn_flag'] = this.btnFlag;
    data['gift_message'] = this.giftMessage;
    return data;
  }
}