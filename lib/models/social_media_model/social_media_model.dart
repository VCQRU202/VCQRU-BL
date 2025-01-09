class SocialMediaModel {
  bool? success;
  String? message;
  Data? data;

  SocialMediaModel({this.success, this.message, this.data});

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
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
  String? socialMediaRequired;
  String? contactNumberRequired;
  String? contactNumberURL;
  String? contactUSRequired;
  String? contactUSURL;
  String? eMailRequired;
  String? eMailURL;
  String? facebookRequired;
  String? facebookURL;
  String? instagramRequired;
  String? instagramURL;
  String? linkdInRequired;
  String? linkdInURL;
  String? tweeterRequired;
  String? tweeterURL;
  String? youTubeRequired;
  String? youTubeURL;

  Data(
      {this.socialMediaRequired,
        this.contactNumberRequired,
        this.contactNumberURL,
        this.contactUSRequired,
        this.contactUSURL,
        this.eMailRequired,
        this.eMailURL,
        this.facebookRequired,
        this.facebookURL,
        this.instagramRequired,
        this.instagramURL,
        this.linkdInRequired,
        this.linkdInURL,
        this.tweeterRequired,
        this.tweeterURL,
        this.youTubeRequired,
        this.youTubeURL});

  Data.fromJson(Map<String, dynamic> json) {
    socialMediaRequired = json['socialMediaRequired'];
    contactNumberRequired = json['contactNumberRequired'];
    contactNumberURL = json['contactNumberURL'];
    contactUSRequired = json['contactUSRequired'];
    contactUSURL = json['contactUSURL'];
    eMailRequired = json['eMailRequired'];
    eMailURL = json['eMailURL'];
    facebookRequired = json['facebookRequired'];
    facebookURL = json['facebookURL'];
    instagramRequired = json['instagramRequired'];
    instagramURL = json['instagramURL'];
    linkdInRequired = json['linkdInRequired'];
    linkdInURL = json['linkdInURL'];
    tweeterRequired = json['tweeterRequired'];
    tweeterURL = json['tweeterURL'];
    youTubeRequired = json['youTubeRequired'];
    youTubeURL = json['youTubeURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socialMediaRequired'] = this.socialMediaRequired;
    data['contactNumberRequired'] = this.contactNumberRequired;
    data['contactNumberURL'] = this.contactNumberURL;
    data['contactUSRequired'] = this.contactUSRequired;
    data['contactUSURL'] = this.contactUSURL;
    data['eMailRequired'] = this.eMailRequired;
    data['eMailURL'] = this.eMailURL;
    data['facebookRequired'] = this.facebookRequired;
    data['facebookURL'] = this.facebookURL;
    data['instagramRequired'] = this.instagramRequired;
    data['instagramURL'] = this.instagramURL;
    data['linkdInRequired'] = this.linkdInRequired;
    data['linkdInURL'] = this.linkdInURL;
    data['tweeterRequired'] = this.tweeterRequired;
    data['tweeterURL'] = this.tweeterURL;
    data['youTubeRequired'] = this.youTubeRequired;
    data['youTubeURL'] = this.youTubeURL;
    return data;
  }
}