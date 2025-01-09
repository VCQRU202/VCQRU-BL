class ReferralModel {
  bool? success;
  String? message;
  List<Data>? data;

  ReferralModel({this.success, this.message, this.data});

  ReferralModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? consumerName;
  String? entryDate;
  String? status;

  Data({this.consumerName, this.entryDate, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    consumerName = json['consumerName'];
    entryDate = json['entry_Date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['consumerName'] = this.consumerName;
    data['entry_Date'] = this.entryDate;
    data['status'] = this.status;
    return data;
  }
}