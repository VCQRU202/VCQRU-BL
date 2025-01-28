class ClaimMainModel {
  bool? success;
  String? message;
  Data? data;

  ClaimMainModel({this.success, this.message, this.data});

  ClaimMainModel.fromJson(Map<String, dynamic> json) {
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
  ClaimRequired? claimRequired;
  List<Icons>? icons;

  Data({this.claimRequired, this.icons});

  Data.fromJson(Map<String, dynamic> json) {
    claimRequired = json['claimRequired'] != null
        ? new ClaimRequired.fromJson(json['claimRequired'])
        : null;
    if (json['icons'] != null) {
      icons = <Icons>[];
      json['icons'].forEach((v) {
        icons!.add(new Icons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.claimRequired != null) {
      data['claimRequired'] = this.claimRequired!.toJson();
    }
    if (this.icons != null) {
      data['icons'] = this.icons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimRequired {
  String? claimstatus;

  ClaimRequired({this.claimstatus});

  ClaimRequired.fromJson(Map<String, dynamic> json) {
    claimstatus = json['claimstatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claimstatus'] = this.claimstatus;
    return data;
  }
}

class Icons {
  String? id;
  String? imagePath;
  String? iconName;
  String? containts;
  bool? isChecked;
  bool? isApprovalRequired;

  Icons(
      {this.id,
        this.imagePath,
        this.iconName,
        this.containts,
        this.isChecked,
        this.isApprovalRequired});

  Icons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['imagePath'];
    iconName = json['iconName'];
    containts = json['containts'];
    isChecked = json['isChecked'];
    isApprovalRequired = json['isApprovalRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['iconName'] = this.iconName;
    data['containts'] = this.containts;
    data['isChecked'] = this.isChecked;
    data['isApprovalRequired'] = this.isApprovalRequired;
    return data;
  }
}