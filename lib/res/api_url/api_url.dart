class AppUrl {
  //---comp name

  //----comp ID
   static const CompId_QA = 'Comp-1423';
  // static const CompId_UAT = 'Comp-1647';
 // static const CompId_LIVE = 'Comp-1669';
  static const Comp_ID = CompId_QA;

  //----Image
  static const String ImageViewURL_QA = "https://qa.vcqru.com";
  //static const String ImageViewURL_UAT = "https://uat.vcqru.com";
   //static const String ImageViewURL_Live = "https://www.vcqru.com";

  static const String ImageViewURL = ImageViewURL_QA;

  //-----Base Url
   static const String baseUrl_QA = "https://vrkableuat.vcqru.com/api/";
  // static const String baseUrl_UAT = "https://api.vcqru.com/api/";
 // static const String baseUrl_LIVE = "https://api2.vcqru.com/api/";
  static const String baseUrl = baseUrl_QA;

//----login
  static const String BRAND_SETTING = baseUrl + "VendorAppSetting";
  static const String REGISTRATION_FIELD = baseUrl + "UserRegistrationFields/1";
  static const String SCAN_CODE = baseUrl + "appcode";
  static const String SCAN_CODE_GENEUNITY = baseUrl + "appcheckgenuenity";
  static const String LOGIN_URL = baseUrl + "ApiLogin";
  static const String SEND_OTP = baseUrl + "SendOTPLogin";
  static const String Verify_OTP = baseUrl + "BlValidateOtpForLogin";
  static const String PAN_VERIFY = baseUrl + "PancardVerificatioin";
  static const String REGISTER = baseUrl + "BLConsumerRegistration";
  static const String SendOTPFOR_KYC = baseUrl + "SendOTPForKYC";
  static const String AADHAR_VERIFY_OTP = baseUrl + "ValidateOTPForKYC";
  static const String BANK_ACCOUNT_VERIFY = baseUrl + "BankAccountVerification";
  static const String KYC_STATUS = baseUrl + "UserKycStatus";


  static const String warningMSG="Sorry We are unable to process your request at this time. Please try after sometime";
}
