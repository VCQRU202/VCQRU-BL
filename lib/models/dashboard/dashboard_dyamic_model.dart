class DashboardDynamicModel {
  bool? success;
  String? message;
  Data? data;

  DashboardDynamicModel({this.success, this.message, this.data});

  DashboardDynamicModel.fromJson(Map<String, dynamic> json) {
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
  List<DashboardIcons>? dashboardIcons;
  List<SidebarIcons>? sidebarIcons;
  AdditionalData? additionalData;

  Data({this.dashboardIcons, this.sidebarIcons, this.additionalData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dashboardIcons'] != null) {
      dashboardIcons = <DashboardIcons>[];
      json['dashboardIcons'].forEach((v) {
        dashboardIcons!.add(new DashboardIcons.fromJson(v));
      });
    }
    if (json['sidebarIcons'] != null) {
      sidebarIcons = <SidebarIcons>[];
      json['sidebarIcons'].forEach((v) {
        sidebarIcons!.add(new SidebarIcons.fromJson(v));
      });
    }
    additionalData = json['additionalData'] != null
        ? new AdditionalData.fromJson(json['additionalData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboardIcons != null) {
      data['dashboardIcons'] =
          this.dashboardIcons!.map((v) => v.toJson()).toList();
    }
    if (this.sidebarIcons != null) {
      data['sidebarIcons'] = this.sidebarIcons!.map((v) => v.toJson()).toList();
    }
    if (this.additionalData != null) {
      data['additionalData'] = this.additionalData!.toJson();
    }
    return data;
  }
}

class DashboardIcons {
  var id;
  String? imagePath;
  String? iconName;
  String? order;
  bool? isChecked;

  DashboardIcons(
      {this.id, this.imagePath, this.iconName, this.order, this.isChecked});

  DashboardIcons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['imagePath'];
    iconName = json['iconName'];
    order = json['order'];
    isChecked = json['isChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['iconName'] = this.iconName;
    data['order'] = this.order;
    data['isChecked'] = this.isChecked;
    return data;
  }
}
class SidebarIcons {
  String? id;
  String? imagePath;
  String? iconName;
  String? order;
  bool? isChecked;

  SidebarIcons(
      {this.id, this.imagePath, this.iconName, this.order, this.isChecked});

  SidebarIcons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagePath = json['imagePath'];
    iconName = json['iconName'];
    order = json['order'];
    isChecked = json['isChecked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['iconName'] = this.iconName;
    data['order'] = this.order;
    data['isChecked'] = this.isChecked;
    return data;
  }
}
class AdditionalData {
  String? totalPoint;
  String? txtPoint;
  String? reedemPoint;
  String? txtreedemPoint;
  String? avlaiblepoint;
  String? txtavlaiblepoint;
  String? loyalitypoint;

  AdditionalData(
      {this.totalPoint,
        this.txtPoint,
        this.reedemPoint,
        this.txtreedemPoint,
        this.avlaiblepoint,
        this.txtavlaiblepoint,
        this.loyalitypoint});

  AdditionalData.fromJson(Map<String, dynamic> json) {
    totalPoint = json['totalPoint'];
    txtPoint = json['txtPoint'];
    reedemPoint = json['reedemPoint'];
    txtreedemPoint = json['txtreedemPoint'];
    avlaiblepoint = json['avlaiblepoint'];
    txtavlaiblepoint = json['txtavlaiblepoint'];
    loyalitypoint = json['Loyalitypoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPoint'] = this.totalPoint;
    data['txtPoint'] = this.txtPoint;
    data['reedemPoint'] = this.reedemPoint;
    data['txtreedemPoint'] = this.txtreedemPoint;
    data['avlaiblepoint'] = this.avlaiblepoint;
    data['txtavlaiblepoint'] = this.txtavlaiblepoint;
    data['Loyalitypoint'] = this.loyalitypoint;
    return data;
  }
}