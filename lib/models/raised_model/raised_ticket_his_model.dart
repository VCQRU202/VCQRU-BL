class RaisedTicketHistoryModel {
  bool? success;
  String? message;
  List<Data>? data;

  RaisedTicketHistoryModel({this.success, this.message, this.data});

  RaisedTicketHistoryModel.fromJson(Map<String, dynamic> json) {
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
  String? ticketId;
  String? description;
  String? createdAt;
  String? status;
  String? compId;
  String? mConsumerid;
  String? remaks;
  String? category;
  String? updatedDate;

  Data(
      {this.ticketId,
        this.description,
        this.createdAt,
        this.status,
        this.compId,
        this.mConsumerid,
        this.remaks,
        this.category,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticketId'];
    description = json['description'];
    createdAt = json['createdAt'];
    status = json['status'];
    compId = json['comp_id'];
    mConsumerid = json['m_Consumerid'];
    remaks = json['remaks'];
    category = json['category'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketId'] = this.ticketId;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['status'] = this.status;
    data['comp_id'] = this.compId;
    data['m_Consumerid'] = this.mConsumerid;
    data['remaks'] = this.remaks;
    data['category'] = this.category;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}