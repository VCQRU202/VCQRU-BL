class DashBoardModel {
  bool? success;
  String? message;
  DashBoardData? data;

  DashBoardModel({this.success, this.message, this.data});

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DashBoardData.fromJson(json['data']) : null;
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

class DashBoardData {
  var totalCode;
  var successCode;
  var reedemPoint;
  var transferredCash;
  var totalPoint;
  var totalcounterfeit;
  var successcounterfeit;

  DashBoardData(
      {this.totalCode,
        this.successCode,
        this.reedemPoint,
        this.transferredCash,
        this.totalPoint,
        this.totalcounterfeit,
        this.successcounterfeit});

  DashBoardData.fromJson(Map<String, dynamic> json) {
    totalCode = json['totalCode'];
    successCode = json['successCode'];
    reedemPoint = json['reedemPoint'];
    transferredCash = json['transferredCash'];
    totalPoint = json['totalPoint'];
    totalcounterfeit = json['totalcounterfeit'];
    successcounterfeit = json['successcounterfeit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCode'] = this.totalCode;
    data['successCode'] = this.successCode;
    data['reedemPoint'] = this.reedemPoint;
    data['transferredCash'] = this.transferredCash;
    data['totalPoint'] = this.totalPoint;
    data['totalcounterfeit'] = this.totalcounterfeit;
    data['successcounterfeit'] = this.successcounterfeit;
    return data;
  }
}