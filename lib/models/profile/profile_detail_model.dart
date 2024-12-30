class ProfileDetailModel {
  bool? success;
  String? message;
  List<ProfileDetailData>? data;

  ProfileDetailModel({this.success, this.message, this.data});

  ProfileDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProfileDetailData>[];
      json['data'].forEach((v) {
        data!.add(new ProfileDetailData.fromJson(v));
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

class ProfileDetailData {
  String? lableName;

  String? data;

  ProfileDetailData(
      {this.lableName,
        this.data});

  ProfileDetailData.fromJson(Map<String, dynamic> json) {
    lableName = json['lableName'];

    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lableName'] = this.lableName;
    data['data'] = this.data;
    return data;
  }
}