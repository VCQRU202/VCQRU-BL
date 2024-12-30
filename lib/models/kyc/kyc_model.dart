class KycDetailsModel {
  bool? success;
  String? message;
  KycData? data;

  KycDetailsModel({this.success, this.message, this.data});

  KycDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new KycData.fromJson(json['data']) : null;
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

class KycData {
  var ifscCode;
  var accountNo;
  var panName;
  var panCardNumber;
  var dateOfBirth;
  var aadharNo;
  var aadharName;
  var upiId;
  var upiname;
  var holdername;

  KycData(
      {this.ifscCode,
        this.accountNo,
        this.panName,
        this.panCardNumber,
        this.dateOfBirth,
        this.aadharNo,
        this.aadharName,
        this.upiId,
        this.holdername,
        this.upiname});

  KycData.fromJson(Map<String, dynamic> json) {
    ifscCode = json['ifscCode'];
    accountNo = json['accountNo'];
    panName = json['panName'];
    panCardNumber = json['panCardNumber'];
    dateOfBirth = json['dateOfBirth'];
    aadharNo = json['aadharNo'];
    aadharName = json['aadharName'];
    holdername = json['accountHoldername'];
    upiId = json['upiId'];
    upiname = json['upiname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ifscCode'] = this.ifscCode;
    data['accountNo'] = this.accountNo;
    data['panName'] = this.panName;
    data['panCardNumber'] = this.panCardNumber;
    data['dateOfBirth'] = this.dateOfBirth;
    data['aadharNo'] = this.aadharNo;
    data['aadharName'] = this.aadharName;
    data['upiId'] = this.upiId;
    data['accountHoldername'] = this.holdername;
    data['upiname'] = this.upiname;
    return data;
  }
}