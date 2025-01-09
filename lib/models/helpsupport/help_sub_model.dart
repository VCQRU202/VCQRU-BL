class HelpSubAnsModel {
  bool? success;
  String? message;
  List<Data>? data;

  HelpSubAnsModel({this.success, this.message, this.data});

  HelpSubAnsModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? topicid;
  String? faqquestion;
  String? faqanswer;

  Data({this.id, this.topicid, this.faqquestion, this.faqanswer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicid = json['topicid'];
    faqquestion = json['faqquestion'];
    faqanswer = json['faqanswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topicid'] = this.topicid;
    data['faqquestion'] = this.faqquestion;
    data['faqanswer'] = this.faqanswer;
    return data;
  }
}