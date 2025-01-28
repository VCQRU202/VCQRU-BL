class ClaimConfirmDataModel {
  bool? success;
  String? message;
  Data? data;

  ClaimConfirmDataModel({this.success, this.message, this.data});

  ClaimConfirmDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Consumerdetails>? consumerdetails;
  Confirmdata? confirmdata;
  List<Message>? message;
  Data({this.consumerdetails, this.confirmdata,this.message});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['consumerdetails'] != null) {
      consumerdetails = <Consumerdetails>[];
      json['consumerdetails'].forEach((v) {
        consumerdetails!.add(new Consumerdetails.fromJson(v));
      });
    }
    confirmdata = json['confirmdata'] != null
        ? new Confirmdata.fromJson(json['confirmdata'])
        : null;
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.consumerdetails != null) {
      data['consumerdetails'] =
          this.consumerdetails!.map((v) => v.toJson()).toList();
    }
    if (this.confirmdata != null) {
      data['confirmdata'] = this.confirmdata!.toJson();
    }
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Consumerdetails {
  String? key;
  String? value;

  Consumerdetails({this.key, this.value});

  Consumerdetails.fromJson(Map<String, dynamic> json) {
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

class Confirmdata {
  String? heading;
  String? headingparagraph;
  String? methodname;
  String? paymentDetails;
  String? payeeName;
  bool? flag;
  String? alternatedata;

  Confirmdata(
      {this.heading,
        this.headingparagraph,
        this.methodname,
        this.paymentDetails,
        this.payeeName,
        this.flag,
        this.alternatedata});

  Confirmdata.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    headingparagraph = json['headingparagraph'];
    methodname = json['methodname'];
    paymentDetails = json['paymentDetails'];
    payeeName = json['payeeName'];
    flag = json['flag'];
    alternatedata = json['alternatedata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading'] = this.heading;
    data['headingparagraph'] = this.headingparagraph;
    data['methodname'] = this.methodname;
    data['paymentDetails'] = this.paymentDetails;
    data['payeeName'] = this.payeeName;
    data['flag'] = this.flag;
    data['alternatedata'] = this.alternatedata;
    return data;
  }
}
class Message {
  String? key;
  String? value;

  Message({this.key, this.value});

  Message.fromJson(Map<String, dynamic> json) {
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