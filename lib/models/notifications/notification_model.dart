class NotificationModel {
  bool? success;
  String? message;
  List<NotificationData>? data=[];

  NotificationModel({this.success, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
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

class NotificationData {
  String? profileImage;
  String? formattedCreatedAt;
  var iD;
  bool? readStatus;
  String? compId;
  String? messgae;
  String? apiurl;
  String? title;
  String? notiType;
  String? kycCat;

  NotificationData(
      {this.profileImage,
        this.formattedCreatedAt,
        this.iD,
        this.readStatus,
        this.compId,
        this.messgae,
        this.apiurl,
        this.title,
        this.notiType,
        this.kycCat});

  NotificationData.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    formattedCreatedAt = json['formatted_created_at'];
    iD = json['ID'];
    readStatus = json['readStatus'];
    compId = json['Comp_id'];
    messgae = json['messgae'];
    apiurl = json['apiurl'];
    title = json['title'];
    notiType = json['notiType'];
    kycCat = json['KycCat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['formatted_created_at'] = this.formattedCreatedAt;
    data['ID'] = this.iD;
    data['readStatus'] = this.readStatus;
    data['Comp_id'] = this.compId;
    data['messgae'] = this.messgae;
    data['apiurl'] = this.apiurl;
    data['title'] = this.title;
    data['notiType'] = this.notiType;
    data['KycCat'] = this.kycCat;
    return data;
  }
}