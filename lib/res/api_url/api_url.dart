class AppUrl {
  //---comp name

  //----comp ID
   static const CompId_QA = 'Comp-1436';
  // static const CompId_UAT = 'Comp-1647';
 // static const CompId_LIVE = 'Comp-1669';
  static const Comp_ID = CompId_QA;

  //----Image
  static const String ImageViewURL_QA = "https://qa.vcqru.com";
  //static const String ImageViewURL_UAT = "https://uat.vcqru.com";
   //static const String ImageViewURL_Live = "https://www.vcqru.com";

  static const String ImageViewURL = ImageViewURL_QA;

  //-----Base Url
   static const String baseUrl_QA = "https://apicore.vcqru.com/api/";
  // static const String baseUrl_UAT = "https://api.vcqru.com/api/";
 // static const String baseUrl_LIVE = "https://api2.vcqru.com/api/";
  static const String baseUrl = baseUrl_QA;

//----login
  static const String BRAND_SETTING = baseUrl + "BrandSetting";
  static const String GETFIELD_SETTING = baseUrl + "UserRegistrationFields";
  static const String SCAN_CODE = baseUrl + "VerifyCoupon";
  static const String LOGIN_URL = baseUrl + "ApiLogin";
  static const String SEND_OTP = baseUrl + "SendOTPLogin";
  static const String Verify_OTP = baseUrl + "ValidateOTPForLogin";
  static const String PAN_VERIFY = baseUrl + "PancardVerify";
  static const String REGISTER = baseUrl + "UserRegistration";
  static const String SendADHAROTPFOR_KYC = baseUrl + "SendOTPForKYCAadhar";
  static const String AADHAR_VERIFY_OTP = baseUrl + "ValidateOTPForKYCAadhar";
  static const String BANK_ACCOUNT_VERIFY = baseUrl + "BankAccountVerification";
  static const String KYC_STATUS = baseUrl + "UserKycStatus";
  static const String CODE_HISTORY = baseUrl + "ApiCodeCheckHistory";
  static const String DASHBOARD = baseUrl + "Dashboard";
  static const String GETPROFILE = baseUrl + "Profiledetails";
  static const String GIFTLIST = baseUrl + "GetVerdoerwiseGiftList";
  static const String GETPROFILE_DETAIL = baseUrl + "Profiledetailswithdata";
  static const String UPDATE_PROFILE = baseUrl + "Updateprofile";
  static const String SUBMIT_CLAIM = baseUrl + "ApiSubmitClaim";
  static const String CLAIM_HISTORY = baseUrl + "ApiClaimHistory";
  static const String INTRODUCTION = baseUrl + "Introduction";
  static const String UPIVERIFY = baseUrl + "UPI_verification";
  static const String KYC_DETAILS = baseUrl + "USERKYCDETAILSBL";
  static const String IFSC_CODE_GET = baseUrl + "Getbankdetailsbyifsc";
  static const String BANNER = baseUrl + "Banner";
  static const String NOTIFICATIONS = baseUrl + "GetNotification";
  static const String RAISE_TICKET = baseUrl + "TicketRaise/raise-ticket";
  static const String HELP_SUPPORT = baseUrl + "HelpAndSupportCategory";
  static const String HELP_SUPPORT_SUB = baseUrl + "HelpandsupportFAQ/get-faq";
  static const String PRODUCT_CAT_LIST = baseUrl + "Productcatalog";
  static const String PRODUCT_CAT_DETAILS = baseUrl + "Productcatalogdetails";
  static const String REFERAL_HISTORY = baseUrl + "ReferralHistory";
  static const String REFERAL_CONTENT = baseUrl + "ReferralContents";
  static const String RAISED_HISTORY = baseUrl + "TicketRaise/ticket-history";
  static const String SOCIAL_MEDIA_API = baseUrl + "SocialMediaIcons/get-social-media-icons";
  static const String DASHBOARD_NAME_IMAGE = baseUrl + "DashboardICons";


  static const String warningMSG="Sorry We are unable to process your request at this time. Please try after sometime";
}
