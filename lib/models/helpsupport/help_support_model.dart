class HelpSupportModel {
  bool? success;
  String? message;
  List<HelpData>? data;

  HelpSupportModel({this.success, this.message, this.data});

  HelpSupportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <HelpData>[];
      json['data'].forEach((v) {
        data!.add(new HelpData.fromJson(v));
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

class HelpData {
  String? id;
  String? topic;

  HelpData({this.id, this.topic});

  HelpData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['topic'] = this.topic;
    return data;
  }
}