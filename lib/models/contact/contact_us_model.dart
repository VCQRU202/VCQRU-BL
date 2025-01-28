class ContactUsModel {
  bool? success;
  String? message;
  Data? data;

  ContactUsModel({this.success, this.message, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
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
  String? contactUSAddress;
  String? termandcondition;
  String? aboutUS;
  String? contactUsNo;
  String? contactUsEmail;

  Data(
      {this.contactUSAddress,
        this.termandcondition,
        this.aboutUS,
        this.contactUsNo,
        this.contactUsEmail});

  Data.fromJson(Map<String, dynamic> json) {
    contactUSAddress = json['contactUSAddress'];
    termandcondition = json['termandcondition'];
    aboutUS = json['aboutUS'];
    contactUsNo = json['contactUsNo'];
    contactUsEmail = json['contactUsEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactUSAddress'] = this.contactUSAddress;
    data['termandcondition'] = this.termandcondition;
    data['aboutUS'] = this.aboutUS;
    data['contactUsNo'] = this.contactUsNo;
    data['contactUsEmail'] = this.contactUsEmail;
    return data;
  }
}