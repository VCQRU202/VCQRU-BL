class SubmitClaimFinalModel {
  bool? success;
  String? message;
  Data? data;

  SubmitClaimFinalModel({this.success, this.message, this.data});

  SubmitClaimFinalModel.fromJson(Map<String, dynamic> json) {
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
  var claimedpoint;
  var claimedcash;
  List<ClaimDetails>? claimDetails;

  Data({this.claimedpoint, this.claimedcash, this.claimDetails});

  Data.fromJson(Map<String, dynamic> json) {
    claimedpoint = json['claimedpoint'];
    claimedcash = json['claimedcash'];
    if (json['claimDetails'] != null) {
      claimDetails = <ClaimDetails>[];
      json['claimDetails'].forEach((v) {
        claimDetails!.add(new ClaimDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claimedpoint'] = this.claimedpoint;
    data['claimedcash'] = this.claimedcash;
    if (this.claimDetails != null) {
      data['claimDetails'] = this.claimDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimDetails {
  var key;
  var value;

  ClaimDetails({this.key, this.value});

  ClaimDetails.fromJson(Map<String, dynamic> json) {
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