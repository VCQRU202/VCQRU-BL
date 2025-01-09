class ProfileModel {
  bool? success;
  String? message;
  ProfileData? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  String? mConsumerid;
  String? userID;
  String? consumerName;
  String? email;
  String? mobileNo;
  String? city;
  String? pinCode;
  String? entryDate;
  bool? isActive;
  bool? isDeleted;
  String? address;
  String? perAddress;
  var referralCode;
  bool? isSharedReferralCode;
  String? employeeID;
  String? distributorID;
  String? aadharNumber;
  String? aadharFile;
  String? aadharBack;
  String? aadharUploadDate;
  String? aadharUploadedBy;
  String? aadharSource;
  String? village;
  String? district;
  String? state;
  String? country;
  String? roleId;
  String? createdBy;
  String? compId;
  String? sellerName;
  String? token;
  String? mStarId;
  String? inoxUserType;
  String? vrkabelUserType;
  String? cinNumber;
  String? refCinNumber;
  String? designation;
  String? dob;
  String? gender;
  String? surName;
  String? communicationStatus;
  String? businessStatus;
  String? houseNumber;
  String? landMark;
  String? ownerNumber;
  String? shopName;
  String? pancardNumber;
  String? gstNumber;
  String? panCardFile;
  String? shopFile;
  String? otherRole;
  String? profileImage;
  String? vrKblKYCStatus;
  String? additional;
  String? remark;
  String? panekycStatus;
  String? aadharKycStatus;
  String? bankKycStatus;
  String? panHolderName;
  String? aadharHolderName;
  String? upiId;
  String? shopAddress;
  String? firmName;
  String? apptoken;
  String? appVersion;
  String? agegroup;
  String? pancardStatus;
  String? brandId;
  String? aadharStatus;
  String? passbookStatus;
  String? ekycStatus;
  String? location;
  String? userType;
  String? addressProof;
  String? upiidImage;
  String? upikycStatus;
  String? teslaPayoutMode;
  String? selfieImage;
  String? userRoleType;
  var percent;

  ProfileData(
      {this.mConsumerid,
        this.userID,
        this.consumerName,
        this.email,
        this.mobileNo,
        this.city,
        this.pinCode,
        this.entryDate,
        this.isActive,
        this.isDeleted,
        this.address,
        this.perAddress,
        this.referralCode,
        this.isSharedReferralCode,
        this.employeeID,
        this.distributorID,
        this.aadharNumber,
        this.aadharFile,
        this.aadharBack,
        this.aadharUploadDate,
        this.aadharUploadedBy,
        this.aadharSource,
        this.village,
        this.district,
        this.state,
        this.country,
        this.roleId,
        this.createdBy,
        this.compId,
        this.sellerName,
        this.token,
        this.mStarId,
        this.inoxUserType,
        this.vrkabelUserType,
        this.cinNumber,
        this.refCinNumber,
        this.designation,
        this.dob,
        this.gender,
        this.surName,
        this.communicationStatus,
        this.businessStatus,
        this.houseNumber,
        this.landMark,
        this.ownerNumber,
        this.shopName,
        this.pancardNumber,
        this.gstNumber,
        this.panCardFile,
        this.shopFile,
        this.otherRole,
        this.profileImage,
        this.vrKblKYCStatus,
        this.additional,
        this.remark,
        this.panekycStatus,
        this.aadharKycStatus,
        this.bankKycStatus,
        this.panHolderName,
        this.aadharHolderName,
        this.upiId,
        this.shopAddress,
        this.firmName,
        this.apptoken,
        this.appVersion,
        this.agegroup,
        this.pancardStatus,
        this.brandId,
        this.aadharStatus,
        this.passbookStatus,
        this.ekycStatus,
        this.location,
        this.userType,
        this.addressProof,
        this.upiidImage,
        this.upikycStatus,
        this.teslaPayoutMode,
        this.selfieImage,
        this.userRoleType,
        this.percent
      });

  ProfileData.fromJson(Map<String, dynamic> json) {
    mConsumerid = json['m_Consumerid'];
    userID = json['user_ID'];
    consumerName = json['consumerName'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    city = json['city'];
    pinCode = json['pinCode'];
    entryDate = json['entry_Date'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    address = json['address'];
    perAddress = json['per_Address'];
    referralCode = json['referralCode'];
    isSharedReferralCode = json['isSharedReferralCode'];
    employeeID = json['employeeID'];
    distributorID = json['distributorID'];
    aadharNumber = json['aadharNumber'];
    aadharFile = json['aadharFile'];
    aadharBack = json['aadharBack'];
    aadharUploadDate = json['aadharUploadDate'];
    aadharUploadedBy = json['aadharUploadedBy'];
    aadharSource = json['aadharSource'];
    village = json['village'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    roleId = json['role_Id'];
    createdBy = json['createdBy'];
    compId = json['comp_id'];
    sellerName = json['sellerName'];
    token = json['token'];
    mStarId = json['mStarId'];
    inoxUserType = json['inox_User_Type'];
    vrkabelUserType = json['vrkabel_User_Type'];
    cinNumber = json['cinNumber'];
    refCinNumber = json['refCinNumber'];
    designation = json['designation'];
    dob = json['dob'];
    gender = json['gender'];
    surName = json['surName'];
    communicationStatus = json['communicationStatus'];
    businessStatus = json['businessStatus'];
    houseNumber = json['houseNumber'];
    landMark = json['landMark'];
    ownerNumber = json['ownerNumber'];
    shopName = json['shopName'];
    pancardNumber = json['pancardNumber'];
    gstNumber = json['gstNumber'];
    panCardFile = json['panCardFile'];
    shopFile = json['shopFile'];
    otherRole = json['otherRole'];
    profileImage = json['profileImage'];
    vrKblKYCStatus = json['vrKblKYCStatus'];
    additional = json['additional'];
    remark = json['remark'];
    panekycStatus = json['panekycStatus'];
    aadharKycStatus = json['aadharKycStatus'];
    bankKycStatus = json['bankKycStatus'];
    panHolderName = json['panHolderName'];
    aadharHolderName = json['aadharHolderName'];
    upiId = json['upiId'];
    shopAddress = json['shopAddress'];
    firmName = json['firmName'];
    apptoken = json['apptoken'];
    appVersion = json['appVersion'];
    agegroup = json['agegroup'];
    pancardStatus = json['pancardStatus'];
    brandId = json['brandId'];
    aadharStatus = json['aadharStatus'];
    passbookStatus = json['passbookStatus'];
    ekycStatus = json['ekycStatus'];
    location = json['location'];
    userType = json['userType'];
    addressProof = json['addressProof'];
    upiidImage = json['upiidImage'];
    upikycStatus = json['upikycStatus'];
    teslaPayoutMode = json['teslaPayoutMode'];
    selfieImage = json['selfieImage'];
    userRoleType = json['userRoleType'];
    percent = json['persent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['m_Consumerid'] = this.mConsumerid;
    data['user_ID'] = this.userID;
    data['consumerName'] = this.consumerName;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['city'] = this.city;
    data['pinCode'] = this.pinCode;
    data['entry_Date'] = this.entryDate;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['address'] = this.address;
    data['per_Address'] = this.perAddress;
    data['referralCode'] = this.referralCode;
    data['isSharedReferralCode'] = this.isSharedReferralCode;
    data['employeeID'] = this.employeeID;
    data['distributorID'] = this.distributorID;
    data['aadharNumber'] = this.aadharNumber;
    data['aadharFile'] = this.aadharFile;
    data['aadharBack'] = this.aadharBack;
    data['aadharUploadDate'] = this.aadharUploadDate;
    data['aadharUploadedBy'] = this.aadharUploadedBy;
    data['aadharSource'] = this.aadharSource;
    data['village'] = this.village;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['role_Id'] = this.roleId;
    data['createdBy'] = this.createdBy;
    data['comp_id'] = this.compId;
    data['sellerName'] = this.sellerName;
    data['token'] = this.token;
    data['mStarId'] = this.mStarId;
    data['inox_User_Type'] = this.inoxUserType;
    data['vrkabel_User_Type'] = this.vrkabelUserType;
    data['cinNumber'] = this.cinNumber;
    data['refCinNumber'] = this.refCinNumber;
    data['designation'] = this.designation;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['surName'] = this.surName;
    data['communicationStatus'] = this.communicationStatus;
    data['businessStatus'] = this.businessStatus;
    data['houseNumber'] = this.houseNumber;
    data['landMark'] = this.landMark;
    data['ownerNumber'] = this.ownerNumber;
    data['shopName'] = this.shopName;
    data['pancardNumber'] = this.pancardNumber;
    data['gstNumber'] = this.gstNumber;
    data['panCardFile'] = this.panCardFile;
    data['shopFile'] = this.shopFile;
    data['otherRole'] = this.otherRole;
    data['profileImage'] = this.profileImage;
    data['vrKblKYCStatus'] = this.vrKblKYCStatus;
    data['additional'] = this.additional;
    data['remark'] = this.remark;
    data['panekycStatus'] = this.panekycStatus;
    data['aadharKycStatus'] = this.aadharKycStatus;
    data['bankKycStatus'] = this.bankKycStatus;
    data['panHolderName'] = this.panHolderName;
    data['aadharHolderName'] = this.aadharHolderName;
    data['upiId'] = this.upiId;
    data['shopAddress'] = this.shopAddress;
    data['firmName'] = this.firmName;
    data['apptoken'] = this.apptoken;
    data['appVersion'] = this.appVersion;
    data['agegroup'] = this.agegroup;
    data['pancardStatus'] = this.pancardStatus;
    data['brandId'] = this.brandId;
    data['aadharStatus'] = this.aadharStatus;
    data['passbookStatus'] = this.passbookStatus;
    data['ekycStatus'] = this.ekycStatus;
    data['location'] = this.location;
    data['userType'] = this.userType;
    data['addressProof'] = this.addressProof;
    data['upiidImage'] = this.upiidImage;
    data['upikycStatus'] = this.upikycStatus;
    data['teslaPayoutMode'] = this.teslaPayoutMode;
    data['selfieImage'] = this.selfieImage;
    data['userRoleType'] = this.userRoleType;
    data['persent'] = this.percent;
    return data;
  }
}