class ReferralCodeModel {
  bool? success;
  String? message;
  Data? data;

  ReferralCodeModel({this.success, this.message, this.data});

  ReferralCodeModel.fromJson(Map<String, dynamic> json) {
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
  String? referralCode;
  String? referralpoint;
  String? referralContents;

  Data({this.referralCode, this.referralpoint, this.referralContents});

  Data.fromJson(Map<String, dynamic> json) {
    referralCode = json['referralCode'];
    referralpoint = json['referralpoint'];
    referralContents = json['referralContents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referralCode'] = this.referralCode;
    data['referralpoint'] = this.referralpoint;
    data['referralContents'] = this.referralContents;
    return data;
  }
}