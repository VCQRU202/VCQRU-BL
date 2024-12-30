class ClaimHistoryModel {
  bool? success;
  String? message;
  List<ClaimData>? data;

  ClaimHistoryModel({this.success, this.message, this.data});

  ClaimHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ClaimData>[];
      json['data'].forEach((v) {
        data!.add(new ClaimData.fromJson(v));
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

class ClaimData {
  String? claimDate;
  int? isapproved;
  String? giftName;
  int? giftValue;
  String? giftImage;
  int? amount;
  String? giftDesc;
  String? message;
  int? giftId;
  List<String>? giftImages;

  ClaimData(
      {this.claimDate,
        this.isapproved,
        this.giftName,
        this.giftValue,
        this.giftImage,
        this.amount,
        this.giftDesc,
        this.message,
        this.giftId,
        this.giftImages});

  ClaimData.fromJson(Map<String, dynamic> json) {
    claimDate = json['claim_date'];
    isapproved = json['isapproved'];
    giftName = json['gift_name'];
    giftValue = json['gift_value'];
    giftImage = json['gift_image'];
    amount = json['amount'];
    giftDesc = json['gift_desc'];
    message = json['message'];
    giftId = json['gift_id'];
    giftImages = json['gift_images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claim_date'] = this.claimDate;
    data['isapproved'] = this.isapproved;
    data['gift_name'] = this.giftName;
    data['gift_value'] = this.giftValue;
    data['gift_image'] = this.giftImage;
    data['amount'] = this.amount;
    data['gift_desc'] = this.giftDesc;
    data['message'] = this.message;
    data['gift_id'] = this.giftId;
    data['gift_images'] = this.giftImages;
    return data;
  }
}